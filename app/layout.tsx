import type { Metadata } from "next";
import { Inter } from "next/font/google";
import { siteBaseUrl } from "@/lib/config";
import { generateMetaTitle } from "@/lib/seo";
import "./globals.css";

const inter = Inter({ subsets: ["latin"], variable: "--font-inter" });
const siteUrl = siteBaseUrl();

export const metadata: Metadata = {
  metadataBase: new URL(siteUrl),
  applicationName: "ThaiNight",
  title: {
    default: generateMetaTitle({ type: "home" }),
    template: "%s",
  },
  description:
    "Thailand nightlife guide for Bangkok, Phuket, Pattaya, and Chiang Mai. Find the best bars, nightclubs, rooftop bars, cocktail bars, live music, happy hours, events, and traveler meetups.",
  alternates: {
    canonical: "/",
  },
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-image-preview": "large",
      "max-snippet": -1,
      "max-video-preview": -1,
    },
  },
  openGraph: {
    type: "website",
    locale: "en_TH",
    siteName: "ThaiNight",
    title: generateMetaTitle({ type: "home" }),
    description:
      "Find Thailand nightlife events, bar specials, club flyers, rooftop bars, nightclubs, cocktail bars, live music, solo traveler meetups, and fresh going-out intelligence.",
    url: "/",
    images: [
      {
        url: "/brand/thainight-og.png",
        width: 1200,
        height: 630,
        alt: "ThaiNight.co Thailand nightlife guide logo",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: generateMetaTitle({ type: "home" }),
    description:
      "Find Thailand nightlife events, bar specials, rooftop bars, nightclubs, cocktail bars, live music, solo traveler meetups, and fresh going-out intelligence.",
    images: ["/brand/thainight-og.png"],
  },
  icons: {
    icon: [
      { url: "/favicon.ico" },
      { url: "/icon.png", type: "image/png", sizes: "512x512" },
    ],
    apple: [{ url: "/apple-icon.png", sizes: "180x180", type: "image/png" }],
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" className="dark">
      <body
        className={`${inter.variable} min-h-screen bg-slate-950 font-sans text-slate-100 antialiased`}
      >
        {children}
      </body>
    </html>
  );
}
