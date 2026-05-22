#!/usr/bin/env node
/**
 * Radarscout Intelligence Fetcher
 * Periodically fetches intelligence from Radarscout and processes it
 */

import path from 'path';
import { fileURLToPath } from 'url';

// Bypass TLS certificate verification for Radarscout (temporary fix)
process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

// Convert ES module path to filesystem path
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// Import the lib files using relative paths
import { supabase } from './supabaseClient.js';
import { analyzeIntelPoster } from '../lib/gemini-intel.ts';

// Telegram config
const TELEGRAM_BOT_TOKEN = process.env.TELEGRAM_BOT_TOKEN;
const TELEGRAM_PUBLIC_CHANNEL_ID = process.env.TELEGRAM_PUBLIC_CHANNEL_ID;
const TELEGRAM_ADMIN_CHAT_ID = process.env.TELEGRAM_ADMIN_CHAT_ID;

// Keywords that trigger Telegram raid alerts
const RAID_KEYWORDS = ["raid", "police", "closed", "shut down", "shutdown", "arrested", "scam"];

async function fetchRadarscoutSignals(options = {}) {
  // Bypass TLS certificate verification for Radarscout (temporary fix)
  process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';
  
  const limit = options.limit ?? 20;
  const minValue = options.minValue ?? 0.1;
  const city = options.city ?? null;

  // Build URL
  const baseUrl = process.env.NEXT_PUBLIC_RADARSCOUT_FEED_URL ?? 'https://radarscout.io';
  const url = new URL(`${baseUrl.replace(/\/+$/, '')}/api/thainight/intelligence`);
  url.searchParams.set("limit", String(limit));
  if (typeof minValue === "number") {
    url.searchParams.set("min_value", String(minValue));
  }
  if (city) {
    // Map city to location
    const CITY_TO_RADARSCOUT_LOCATION = {
      bangkok: "Bangkok",
      pattaya: "Pattaya", 
      phuket: "Phuket",
      "chiang-mai": "Chiang Mai"
    };
    url.searchParams.set("location", CITY_TO_RADARSCOUT_LOCATION[city] || city);
  }

  const token = process.env.RADARSCOUT_FEED_TOKEN ?? process.env.NEXT_PUBLIC_RADARSCOUT_API_KEY;
  if (token && !url.searchParams.has("token")) {
    url.searchParams.set("token", token);
  }
  console.log(`[${new Date().toISOString()}] Radarscout URL: ${url.toString()}`);
  console.log(`[${new Date().toISOString()}] Token present: ${token ? token.substring(0, 5) + '...' : 'null'}`);

  try {
    const response = await fetch(url, {
      next: { revalidate: 15 * 60 },
      headers: token ? { "x-thainight-token": token } : undefined,
    });

    if (!response.ok) {
      console.error(`Radarscout API error: ${response.status}`);
      return [];
    }

    const data = await response.json();
    return Array.isArray(data.items) ? data.items : [];
  } catch (error) {
    console.error("Error fetching from Radarscout:", error);
    return [];
  }
}

async function fetchAndProcessIntelligence() {
  console.log(`[${new Date().toISOString()}] Starting Radarscout intelligence fetch...`);

  try {
    // Fetch recent signals from Radarscout
    const signals = await fetchRadarscoutSignals({
      limit: 20,
      minValue: 0
    });

    console.log(`Fetched ${signals.length} signals from Radarscout`);

    let processedCount = 0;
    let newCount = 0;

    for (const signal of signals) {
      try {
        // Check if we already have this signal
        const { data: existing, error: checkError } = await supabase
          .from("intelligence_feed")
          .select("id")
          .eq("radarscout_id", signal.id)
          .single();

        if (checkError && checkError.code !== "PGRST116") {
          // PGRST116 means no rows returned (which is OK)
          console.error(`Error checking for existing signal ${signal.id}:`, checkError);
          continue;
        }

        if (existing) {
          // Skip if we already have this signal
          continue;
        }

        newCount++;

        // Analyze poster if available
        const posterUrl = signal.media?.image_url ?? signal.media?.imageUrl ?? null;
        let posterAnalysis = null;
        if (posterUrl) {
          try {
            posterAnalysis = await analyzeIntelPoster(posterUrl);
          } catch (posterError) {
            console.warn(`Error analyzing poster for signal ${signal.id}:`, posterError);
          }
        }

        // Determine if this is a raid alert
        const isRaidAlert = RAID_KEYWORDS.some(kw => 
          `${signal.title} ${signal.snippet ?? ""}`.toLowerCase().includes(kw)
        );

        // Determine if this should create an event or offer
        const eventLike = /(event|party|dj|live|festival|anniversary|opening|guest|lineup)/i.test(
          `${signal.title} ${signal.snippet ?? ""}`
        );

        const offerLike = /(happy hour|discount|deal|offer|free entry|buy 1 get 1|bogo|ladies night|complimentary|promo)/i.test(
          `${signal.title} ${signal.snippet ?? ""}`
        );

        const shouldQueueEvent = eventLike || (posterAnalysis && posterAnalysis.shouldCreateEvent);
        const shouldQueueOffer = offerLike || (posterAnalysis && posterAnalysis.shouldCreateOffer);

        // Insert into intelligence_feed
        const { error: insertError } = await supabase
         .from("intelligence_feed")
         .insert({
           radarscout_id: signal.id,
           source: (signal.source ?? '').toLowerCase(),
           subreddit: signal.subreddit ?? null,
           title: signal.title ?? '',
           url: signal.url ?? '',
           body_snippet: signal.snippet ?? '',
           author: signal.author ?? null,
           posted_at: signal.posted_at,
           reddit_score: signal.score,
           comment_count: signal.comment_count,
           city: signal.ai_scores?.city,
           area: signal.ai_scores?.area,
           venue_type: signal.ai_scores?.venue_type,
           travel_intent: signal.ai_scores?.travel_intent,
           credibility: signal.ai_scores?.credibility,
           thainight_value: signal.ai_scores?.thainight_value,
           sentiment: signal.ai_scores?.sentiment,
           extracted_venues: signal.ai_scores?.extracted_venue_names ?? [],
           matched_venue_slug: signal.thainight_match?.venue_slug ?? null,
           matched_confidence: signal.thainight_match?.confidence ?? null,
           is_raid_alert: isRaidAlert,
           received_at: new Date().toISOString(),
         });

        if (insertError) {
          console.error(`Error inserting signal ${signal.id}:`, insertError);
          continue;
        }

        processedCount++;

        // Handle event creation
        if (shouldQueueEvent) {
          try {
            await supabase.from("event_flyers").insert({
              venue_slug: signal.thainight_match?.venue_slug ?? null,
              city: signal.ai_scores?.city ?? "thailand",
              title: posterAnalysis?.suggestedTitle ?? signal.title,
              description: posterAnalysis?.suggestedSummary ?? signal.snippet ?? null,
              flyer_image_url: posterUrl,
              source_url: signal.url,
              source_type: "radarscout",
              status: "pending",
            });
          } catch (eventError) {
            console.error(`Error creating event for signal ${signal.id}:`, eventError);
          }
        }

        // Handle offer creation
        if (shouldQueueOffer) {
          try {
            await supabase.from("venue_offers").insert({
              venue_slug: signal.thainight_match?.venue_slug ?? null,
              city: signal.ai_scores?.city ?? "thailand",
              title: posterAnalysis?.suggestedTitle ?? signal.title,
              description: posterAnalysis?.suggestedSummary ?? signal.snippet ?? null,
              offer_label: posterAnalysis?.offerLabel ?? null,
              image_url: posterUrl,
              source_url: signal.url,
              source_type: "radarscout",
              status: "pending",
            });
          } catch (offerError) {
            console.error(`Error creating offer for signal ${signal.id}:`, offerError);
          }
        }

        // Send raid alert to Telegram
        if (isRaidAlert) {
          try {
            const city = signal.ai_scores?.city ?? "Thailand";
            const cityName = city.charAt(0).toUpperCase() + city.slice(1);
            const venueStr = signal.thainight_match?.venue_name
              ? `\n<b>Venue:</b> ${signal.thainight_match.venue_name}`
              : signal.ai_scores?.extracted_venue_names?.length
                ? `\n<b>Mentioned:</b> ${signal.ai_scores.extracted_venue_names.slice(0, 3).join(", ")}`
                : "";
            const venueLink = signal.thainight_match?.venue_slug
              ? `\n<a href="https://thainight.co/${signal.ai_scores?.city}/bars/${signal.thainight_match.venue_slug}">View Venue →</a>`
              : "";

            const alertText = [
              `🚨 <b>ALERT — ${cityName} Nightlife</b>`,
              "",
              `<b>Source:</b> r/${signal.subreddit ?? "Reddit"}`,
              `<b>Report:</b> ${signal.title}`,
              venueStr,
              venueLink,
              "",
              `<a href="${signal.url}">View original post →</a>`,
              "",
              `<i>Via RadarScout intelligence feed. Verify before heading out.</i>`,
            ]
              .filter(l => l !== undefined)
              .join("\n");

            if (TELEGRAM_BOT_TOKEN && TELEGRAM_PUBLIC_CHANNEL_ID) {
              await fetch(`https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                  chat_id: TELEGRAM_PUBLIC_CHANNEL_ID,
                  text: alertText,
                  parse_mode: "HTML",
                  disable_web_page_preview: true,
                }),
              });
            }

            if (TELEGRAM_BOT_TOKEN && TELEGRAM_ADMIN_CHAT_ID) {
              await fetch(`https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                  chat_id: TELEGRAM_ADMIN_CHAT_ID,
                  text: `🚨 Raid alert pushed to channel from RadarScout\nSource: ${signal.url}`,
                  parse_mode: "HTML",
                }),
              });
            }
          } catch (telegramError) {
            console.error(`Error sending Telegram alert for signal ${signal.id}:`, telegramError);
          }
        }
        // Send high-value intelligence to admin
        else if ((signal.ai_scores?.thainight_value ?? 0) >= 0.85) {
          try {
            const adminText = [
              `⚡ <b>High-value intelligence</b> (score: ${signal.ai_scores?.thainight_value?.toFixed(2)})`,
              `<b>r/${signal.subreddit}</b>: ${signal.title}`,
              signal.thainight_match?.venue_slug
                ? `Matched venue: ${signal.thainight_match.venue_name}`
                : "No venue match",
              `<a href="${signal.url}">View post →</a>`,
            ].join("\n");

            if (TELEGRAM_BOT_TOKEN && TELEGRAM_ADMIN_CHAT_ID) {
              await fetch(`https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage`, {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify({
                  chat_id: TELEGRAM_ADMIN_CHAT_ID,
                  text: adminText,
                  parse_mode: "HTML",
                }),
              });
            }
          } catch (adminError) {
            console.error(`Error sending admin alert for signal ${signal.id}:`, adminError);
          }
        }

        // Small delay to avoid rate limiting
        await new Promise(resolve => setTimeout(resolve, 100));
      } catch (itemError) {
        console.error(`Error processing signal ${signal.id}:`, itemError);
        continue;
      }
    }

    console.log(`[${new Date().toISOString()}] Finished. Processed: ${processedCount}, New: ${newCount}`);
  } catch (error) {
    console.error(`[${new Date().toISOString()}] Error in Radarscout intelligence fetch:`, error);
  }
}

// Run if called directly
if (import.meta.url === `file://${process.argv[1]}`) {
  fetchAndProcessIntelligence().catch(console.error);
}

export default fetchAndProcessIntelligence;