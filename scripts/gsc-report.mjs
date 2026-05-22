#!/usr/bin/env node

import fs from "node:fs";
import path from "node:path";
import { google } from "googleapis";

const PROJECT_ROOT = path.resolve(path.dirname(new URL(import.meta.url).pathname), "..");
const DEFAULT_OUTPUT = path.join(PROJECT_ROOT, "data", "gsc-latest.json");

function parseArgs(argv) {
  const args = { days: 14, trendDays: 28, output: DEFAULT_OUTPUT };
  for (let i = 2; i < argv.length; i += 1) {
    const token = argv[i];
    if (token === "--help" || token === "-h") args.help = true;
    else if (token === "--site") args.site = argv[++i];
    else if (token === "--days") args.days = Number(argv[++i]);
    else if (token === "--trend-days") args.trendDays = Number(argv[++i]);
    else if (token === "--output") args.output = argv[++i];
  }
  return args;
}

function readEnvFile() {
  const envPath = path.join(PROJECT_ROOT, ".env.local");
  if (!fs.existsSync(envPath)) return {};
  const out = {};
  for (const line of fs.readFileSync(envPath, "utf8").split(/\r?\n/)) {
    if (!line || line.trim().startsWith("#") || !line.includes("=")) continue;
    const idx = line.indexOf("=");
    const key = line.slice(0, idx).trim();
    const value = line.slice(idx + 1).trim();
    out[key] = value;
  }
  return out;
}

function requireValue(name, value) {
  if (!value) throw new Error(`Missing required setting: ${name}`);
  return value;
}

function toDateString(date) {
  return date.toISOString().slice(0, 10);
}

function sumMetric(rows, key) {
  return (rows || []).reduce((sum, row) => sum + Number(row?.[key] ?? 0), 0);
}

function avgPosition(rows) {
  const valid = (rows || []).filter((row) => Number(row?.impressions ?? 0) > 0);
  if (valid.length === 0) return 0;
  const weighted = valid.reduce((sum, row) => sum + Number(row.position ?? 0) * Number(row.impressions ?? 0), 0);
  const impressions = sumMetric(valid, "impressions");
  return impressions > 0 ? weighted / impressions : 0;
}

function pctDelta(current, previous) {
  if (previous === 0) return current === 0 ? 0 : null;
  return ((current - previous) / previous) * 100;
}

function splitRecentPeriods(rows, periodDays) {
  const sorted = [...(rows || [])].sort((a, b) => {
    const aKey = String(a?.keys?.[0] ?? "");
    const bKey = String(b?.keys?.[0] ?? "");
    return aKey.localeCompare(bKey);
  });

  const recent = sorted.slice(-periodDays);
  const previous = sorted.slice(-(periodDays * 2), -periodDays);
  return { recent, previous };
}

function fmtDeltaPct(value) {
  if (value === null) return "NEW";
  return `${value >= 0 ? "+" : ""}${value.toFixed(2)}%`;
}

async function buildAuthClient(config) {
  const oauthClientPath = config.GSC_OAUTH_CLIENT_PATH ?? "secrets/gsc-oauth-client.json";
  const oauthTokenPath = config.GSC_OAUTH_TOKEN_PATH ?? "secrets/gsc-oauth-token.json";
  const oauthClientJson = config.GSC_OAUTH_CLIENT_JSON;
  const oauthTokenJson = config.GSC_OAUTH_TOKEN_JSON;
  const oauthRefreshToken = config.GSC_OAUTH_REFRESH_TOKEN;

  let oauthClientConfig;
  if (config.GSC_OAUTH_CLIENT_ID && config.GSC_OAUTH_CLIENT_SECRET) {
    oauthClientConfig = {
      client_id: config.GSC_OAUTH_CLIENT_ID,
      client_secret: config.GSC_OAUTH_CLIENT_SECRET,
      redirect_uris: [config.GSC_OAUTH_REDIRECT_URI ?? "http://127.0.0.1:53682/oauth2callback"],
    };
  } else if (oauthClientJson) {
    const parsed = JSON.parse(oauthClientJson);
    oauthClientConfig = parsed.installed ?? parsed.web ?? parsed;
  } else if (fs.existsSync(path.resolve(PROJECT_ROOT, oauthClientPath))) {
    const parsed = JSON.parse(fs.readFileSync(path.resolve(PROJECT_ROOT, oauthClientPath), "utf8"));
    oauthClientConfig = parsed.installed ?? parsed.web ?? parsed;
  }

  if (oauthClientConfig) {
    const token =
      oauthRefreshToken
        ? { refresh_token: oauthRefreshToken }
        : oauthTokenJson
          ? JSON.parse(oauthTokenJson)
          : fs.existsSync(path.resolve(PROJECT_ROOT, oauthTokenPath))
            ? JSON.parse(fs.readFileSync(path.resolve(PROJECT_ROOT, oauthTokenPath), "utf8"))
            : null;

    if (!token) {
      throw new Error(
        "Missing GSC OAuth token. Run `npm run gsc:auth` once, or set GSC_OAUTH_REFRESH_TOKEN / GSC_OAUTH_TOKEN_JSON."
      );
    }

    const auth = new google.auth.OAuth2(
      oauthClientConfig.client_id,
      oauthClientConfig.client_secret,
      oauthClientConfig.redirect_uris?.[0] ?? config.GSC_OAUTH_REDIRECT_URI
    );
    auth.setCredentials(token.tokens ?? token);
    return auth;
  }

  const credentialsPath = config.GSC_SERVICE_ACCOUNT_KEY_PATH;
  const credentialsJson = config.GSC_SERVICE_ACCOUNT_KEY_JSON;

  if (!credentialsPath && !credentialsJson) {
    throw new Error(
      "Missing GSC credentials. For OAuth, set GSC_OAUTH_CLIENT_PATH and run `npm run gsc:auth`. For legacy service accounts, set GSC_SERVICE_ACCOUNT_KEY_PATH or GSC_SERVICE_ACCOUNT_KEY_JSON."
    );
  }

  let credentials;
  if (credentialsPath) {
    credentials = JSON.parse(fs.readFileSync(path.resolve(PROJECT_ROOT, credentialsPath), "utf8"));
  } else {
    credentials = JSON.parse(credentialsJson);
  }

  const auth = new google.auth.GoogleAuth({
    credentials,
    scopes: ["https://www.googleapis.com/auth/webmasters.readonly"],
  });

  return auth.getClient();
}

async function run() {
  const args = parseArgs(process.argv);
  if (args.help) {
    console.log(`Usage:
  node scripts/gsc-report.mjs --site sc-domain:thainight.co --days 14 --trend-days 28 --output data/gsc-latest.json

Settings (in .env.local if flags omitted):
  GSC_SITE_URL=sc-domain:thainight.co

  # Preferred: OAuth as your Google account
  GSC_OAUTH_CLIENT_PATH=secrets/gsc-oauth-client.json
  GSC_OAUTH_TOKEN_PATH=secrets/gsc-oauth-token.json

  # Legacy fallback: service account JSON
  GSC_SERVICE_ACCOUNT_KEY_PATH=secrets/gsc-service-account.json
  # or
  GSC_SERVICE_ACCOUNT_KEY_JSON={...full json...}`);
    return;
  }

  const envFile = readEnvFile();
  const config = { ...envFile, ...process.env };

  const siteUrl = requireValue("GSC_SITE_URL or --site", args.site ?? config.GSC_SITE_URL);
  const days = Number.isFinite(args.days) && args.days > 0 ? Math.floor(args.days) : 14;
  const trendDays = Number.isFinite(args.trendDays) && args.trendDays > 0 ? Math.floor(args.trendDays) : 28;

  const end = new Date();
  const start = new Date();
  start.setDate(end.getDate() - days + 1);
  const trendStart = new Date();
  trendStart.setDate(end.getDate() - trendDays + 1);

  const authClient = await buildAuthClient(config);
  const searchconsole = google.searchconsole({ version: "v1", auth: authClient });

  const [queryRes, pageRes, countryRes, trendRes, deviceRes, sitemapRes] = await Promise.all([
    searchconsole.searchanalytics.query({
      siteUrl,
      requestBody: {
        startDate: toDateString(start),
        endDate: toDateString(end),
        dimensions: ["query"],
        rowLimit: 50,
      },
    }),
    searchconsole.searchanalytics.query({
      siteUrl,
      requestBody: {
        startDate: toDateString(start),
        endDate: toDateString(end),
        dimensions: ["page"],
        rowLimit: 50,
      },
    }),
    searchconsole.searchanalytics.query({
      siteUrl,
      requestBody: {
        startDate: toDateString(start),
        endDate: toDateString(end),
        dimensions: ["country"],
        rowLimit: 30,
      },
    }),
    searchconsole.searchanalytics.query({
      siteUrl,
      requestBody: {
        startDate: toDateString(trendStart),
        endDate: toDateString(end),
        dimensions: ["date"],
        rowLimit: Math.min(trendDays, 365),
      },
    }),
    searchconsole.searchanalytics.query({
      siteUrl,
      requestBody: {
        startDate: toDateString(start),
        endDate: toDateString(end),
        dimensions: ["device"],
        rowLimit: 10,
      },
    }),
    searchconsole.sitemaps.list({ siteUrl }).catch(() => ({ data: { sitemap: [] } })),
  ]);

  const report = {
    generated_at: new Date().toISOString(),
    site: siteUrl,
    range: {
      start_date: toDateString(start),
      end_date: toDateString(end),
      days,
    },
    trend_range: {
      start_date: toDateString(trendStart),
      end_date: toDateString(end),
      days: trendDays,
    },
    performance: {
      top_queries: queryRes.data.rows ?? [],
      top_pages: pageRes.data.rows ?? [],
      by_country: countryRes.data.rows ?? [],
      by_device: deviceRes.data.rows ?? [],
      daily_trend: trendRes.data.rows ?? [],
    },
    sitemaps: sitemapRes.data.sitemap ?? [],
    notes: [
      "Search Console API exposes search performance + sitemap status.",
      "Index Coverage detail is not fully exposed in public API; use GSC UI for full coverage diagnostics.",
    ],
  };

  const trendRows = report.performance.daily_trend ?? [];
  const { recent, previous } = splitRecentPeriods(trendRows, 7);
  const recentClicks = sumMetric(recent, "clicks");
  const previousClicks = sumMetric(previous, "clicks");
  const recentImpressions = sumMetric(recent, "impressions");
  const previousImpressions = sumMetric(previous, "impressions");
  const recentAvgPosition = avgPosition(recent);
  const previousAvgPosition = avgPosition(previous);

  report.weekly_change = {
    period_days: 7,
    data_points: {
      recent: recent.length,
      previous: previous.length,
    },
    clicks: {
      recent: recentClicks,
      previous: previousClicks,
      delta: recentClicks - previousClicks,
      delta_pct: pctDelta(recentClicks, previousClicks),
    },
    impressions: {
      recent: recentImpressions,
      previous: previousImpressions,
      delta: recentImpressions - previousImpressions,
      delta_pct: pctDelta(recentImpressions, previousImpressions),
    },
    avg_position: {
      recent: recentAvgPosition,
      previous: previousAvgPosition,
      delta: recentAvgPosition - previousAvgPosition,
      delta_pct: pctDelta(recentAvgPosition, previousAvgPosition),
      note: "Lower average position is better.",
    },
  };

  const outputPath = path.resolve(PROJECT_ROOT, args.output || DEFAULT_OUTPUT);
  fs.mkdirSync(path.dirname(outputPath), { recursive: true });
  fs.writeFileSync(outputPath, JSON.stringify(report, null, 2));

  const totalClicks = (report.performance.top_pages || []).reduce((sum, row) => sum + (row.clicks ?? 0), 0);
  const totalImpressions = (report.performance.top_pages || []).reduce((sum, row) => sum + (row.impressions ?? 0), 0);

  console.log(`GSC report saved: ${outputPath}`);
  console.log(`Site: ${siteUrl}`);
  console.log(`Range: ${report.range.start_date} -> ${report.range.end_date}`);
  console.log(`Top query rows: ${report.performance.top_queries.length}`);
  console.log(`Top page rows: ${report.performance.top_pages.length}`);
  console.log(`Daily trend rows(${report.trend_range.days}d): ${report.performance.daily_trend.length}`);
  console.log(`Sitemaps found: ${report.sitemaps.length}`);
  console.log(`Clicks(sum top pages): ${totalClicks.toFixed(2)}`);
  console.log(`Impressions(sum top pages): ${totalImpressions.toFixed(2)}`);
  const weekly = report.weekly_change;
  console.log(
    `Weekly delta(7d): clicks ${weekly.clicks.delta >= 0 ? "+" : ""}${weekly.clicks.delta.toFixed(2)} (${fmtDeltaPct(weekly.clicks.delta_pct)}) | ` +
      `impr ${weekly.impressions.delta >= 0 ? "+" : ""}${weekly.impressions.delta.toFixed(2)} (${fmtDeltaPct(weekly.impressions.delta_pct)}) | ` +
      `avg pos ${weekly.avg_position.delta >= 0 ? "+" : ""}${weekly.avg_position.delta.toFixed(2)} (${fmtDeltaPct(weekly.avg_position.delta_pct)})`
  );
}

run().catch((error) => {
  console.error("[gsc-report] failed:", error.message || error);
  process.exit(1);
});
