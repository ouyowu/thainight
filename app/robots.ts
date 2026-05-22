import type { MetadataRoute } from "next";
import { siteBaseUrl } from "@/lib/config";

export default function robots(): MetadataRoute.Robots {
  const baseUrl = siteBaseUrl();

  return {
    rules: [
      {
        userAgent: "*",
        allow: "/",
        disallow: ["/admin", "/api/", "/auth/"],
      },
    ],
    sitemap: `${baseUrl}/sitemap.xml`,
    host: baseUrl,
  };
}
