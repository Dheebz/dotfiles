#!/usr/bin/env bash
set -euo pipefail

if ! command -v bw &>/dev/null; then
  echo "❌ Bitwarden CLI (bw) not installed"
  exit 1
fi

# Initial vault status check
status_json="$(bw status --raw 2>/dev/null || true)"

logged_in() {
  echo "$status_json" | jq -e '.status == "locked" or .status == "unlocked"' >/dev/null
}

unlocked() {
  echo "$status_json" | jq -e '.status == "unlocked"' >/dev/null
}

# 1. Login only if needed
if ! logged_in; then
  echo "🔐 Logging into Bitwarden..."
  bw login
fi

# Refresh status after login
status_json="$(bw status --raw)"

# 2. Unlock vault and get session token
if unlocked; then
  echo "🔓 Vault already unlocked."
else
  echo "🔓 Unlocking Bitwarden vault..."
fi

export BW_SESSION="$(bw unlock --raw)"

# 3. Provide wrapper for safe use
bw_sess() {
  bw --session "$BW_SESSION" "$@"
}
