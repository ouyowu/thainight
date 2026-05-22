#!/usr/bin/env node

import fs from "node:fs";
import http from "node:http";
import path from "node:path";
import { execFile } from "node:child_process";
import { google } from "googleapis";

const PROJECT_ROOT = path.resolve(path.dirname(new URL(import.meta.url).pathname), "..");
const SCOPES = ["https://www.googleapis.com/auth/webmasters.readonly"];

function readEnvFile() {
  const envPath = path.join(PROJECT_ROOT, ".env.local");
  if (!fs.existsSync(envPath)) return {};
  const out = {};
  for (const line of fs.readFileSync(envPath, "utf8").split(/\r?\n/)) {
    if (!line || line.trim().startsWith("#") || !line.includes("=")) continue;
    const idx = line.indexOf("=");
    out[line.slice(0, idx).trim()] = line.slice(idx + 1).trim();
  }
  return out;
}

function loadOAuthClient(config) {
  const clientPath = path.resolve(PROJECT_ROOT, config.GSC_OAUTH_CLIENT_PATH ?? "secrets/gsc-oauth-client.json");
  let parsed;

  if (config.GSC_OAUTH_CLIENT_JSON) {
    parsed = JSON.parse(config.GSC_OAUTH_CLIENT_JSON);
  } else if (fs.existsSync(clientPath)) {
    parsed = JSON.parse(fs.readFileSync(clientPath, "utf8"));
  } else if (config.GSC_OAUTH_CLIENT_ID && config.GSC_OAUTH_CLIENT_SECRET) {
    parsed = {
      installed: {
        client_id: config.GSC_OAUTH_CLIENT_ID,
        client_secret: config.GSC_OAUTH_CLIENT_SECRET,
      },
    };
  } else {
    throw new Error(
      "Missing OAuth client. Download a Google OAuth Desktop client JSON to secrets/gsc-oauth-client.json, or set GSC_OAUTH_CLIENT_ID and GSC_OAUTH_CLIENT_SECRET."
    );
  }

  return parsed.installed ?? parsed.web ?? parsed;
}

function writeHtml(res, status, body) {
  res.writeHead(status, { "Content-Type": "text/html; charset=utf-8" });
  res.end(body);
}

async function run() {
  const config = { ...readEnvFile(), ...process.env };
  const client = loadOAuthClient(config);
  const port = Number(config.GSC_OAUTH_PORT ?? 53682);
  const redirectUri = `http://127.0.0.1:${port}/oauth2callback`;
  const tokenPath = path.resolve(PROJECT_ROOT, config.GSC_OAUTH_TOKEN_PATH ?? "secrets/gsc-oauth-token.json");

  const oauth2 = new google.auth.OAuth2(client.client_id, client.client_secret, redirectUri);
  const authUrl = oauth2.generateAuthUrl({
    access_type: "offline",
    prompt: "consent",
    scope: SCOPES,
  });

  await new Promise((resolve, reject) => {
    const server = http.createServer(async (req, res) => {
      try {
        const url = new URL(req.url ?? "/", redirectUri);
        if (url.pathname !== "/oauth2callback") {
          writeHtml(res, 404, "Not found");
          return;
        }

        const code = url.searchParams.get("code");
        const error = url.searchParams.get("error");
        if (error) throw new Error(error);
        if (!code) throw new Error("Google did not return an authorization code.");

        const { tokens } = await oauth2.getToken(code);
        fs.mkdirSync(path.dirname(tokenPath), { recursive: true });
        fs.writeFileSync(tokenPath, JSON.stringify(tokens, null, 2));

        writeHtml(
          res,
          200,
          "<h1>ThaiNight Search Console authorization saved.</h1><p>You can close this tab and return to the terminal.</p>"
        );
        server.close(() => resolve());
      } catch (error) {
        writeHtml(res, 500, `<h1>Authorization failed</h1><pre>${String(error.message ?? error)}</pre>`);
        server.close(() => reject(error));
      }
    });

    server.listen(port, "127.0.0.1", () => {
      console.log("Opening Google authorization page...");
      console.log(authUrl);
      execFile("open", [authUrl], () => {});
    });
  });

  console.log(`GSC OAuth token saved: ${tokenPath}`);
  console.log("Next: npm run gsc:report");
}

run().catch((error) => {
  console.error("[gsc-auth] failed:", error.message || error);
  process.exit(1);
});
