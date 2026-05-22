#!/usr/bin/env bash
set -e

# Ensure we are in the project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
cd "$PROJECT_ROOT"

# Load environment variables if .env.local exists
if [ -f "$PROJECT_ROOT/.env.local" ]; then
  export $(grep -v '^#' "$PROJECT_ROOT/.env.local" | xargs)
fi

# Run the Radarscout intelligence fetcher
echo "[$(date -u +'%Y-%m-%dT%H:%M:%SZ')] Starting Radarscout intelligence fetch..."
node scripts/fetch-radarscout-log.mjs
echo "[$(date -u +'%Y-%m-%dT%H:%M:%SZ')] Finished Radarscout intelligence fetch."