// Context: ThaiNight image safety. Google Places media is the current venue image source.
// Set NEXT_PUBLIC_USE_GOOGLE_IMAGES=false only when you need to hide those images.
export function isGoogleMediaUrl(url?: string | null): boolean {
  if (!url) return false;
  return url.includes("places.googleapis.com") || url.includes("maps.googleapis.com/maps/api/place/photo");
}

export function canRenderPublicImage(url?: string | null): boolean {
  if (!url) return false;
  return !isGoogleMediaUrl(url) || process.env.NEXT_PUBLIC_USE_GOOGLE_IMAGES !== "false";
}
