type GeminiIntelResult = {
  shouldCreateOffer: boolean;
  shouldCreateEvent: boolean;
  offerLabel: string | null;
  suggestedTitle: string | null;
  suggestedSummary: string | null;
};

const GEMINI_ENDPOINT = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent";

export async function analyzeIntelPoster(imageUrl: string | null | undefined): Promise<GeminiIntelResult | null> {
  const apiKey = process.env.GEMINI_API_KEY ?? process.env.GOOGLE_API_KEY;
  if (!apiKey || !imageUrl) return null;

  try {
    const imageResponse = await fetch(imageUrl);
    if (!imageResponse.ok) return null;

    const mimeType = imageResponse.headers.get("content-type") ?? "image/jpeg";
    const buffer = Buffer.from(await imageResponse.arrayBuffer());
    const base64 = buffer.toString("base64");

    const prompt = [
      "You are classifying a nightlife flyer for ThaiNight.co.",
      "Return strict JSON with these keys only:",
      "shouldCreateOffer:boolean, shouldCreateEvent:boolean, offerLabel:string|null, suggestedTitle:string|null, suggestedSummary:string|null.",
      "Offer labels should be concise, e.g. Free Entry, Happy Hour, Buy 1 Get 1, Ladies Night.",
      "If the image is unreadable or unrelated to nightlife, set both booleans false.",
    ].join(" ");

    const response = await fetch(`${GEMINI_ENDPOINT}?key=${apiKey}`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        contents: [
          {
            parts: [
              {
                inlineData: {
                  mimeType,
                  data: base64,
                },
              },
              { text: prompt },
            ],
          },
        ],
        generationConfig: {
          responseMimeType: "application/json",
        },
      }),
    });

    if (!response.ok) return null;
    const payload = (await response.json()) as {
      candidates?: Array<{ content?: { parts?: Array<{ text?: string }> } }>;
    };
    const text = payload.candidates?.[0]?.content?.parts?.[0]?.text;
    if (!text) return null;
    return JSON.parse(text) as GeminiIntelResult;
  } catch {
    return null;
  }
}
