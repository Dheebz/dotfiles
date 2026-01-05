#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

require_macos

info "Preflight checks..."

if command -v sw_vers >/dev/null 2>&1; then
  info "macOS: $(sw_vers -productVersion)"
fi

if command -v df >/dev/null 2>&1; then
  avail_kb=$(df -Pk / | awk 'NR==2 {print $4}')
  if [[ -n "$avail_kb" ]]; then
    avail_gb=$((avail_kb / 1024 / 1024))
    info "Disk free: ${avail_gb}GB"
    if (( avail_gb < 10 )); then
      warn "Low disk space (<10GB). Consider freeing space before continuing."
    fi
  fi
fi

if command -v curl >/dev/null 2>&1; then
  if curl -fsSL --max-time 5 https://github.com >/dev/null 2>&1; then
    info "Network: OK"
  else
    warn "Network check failed. Some installs may not work."
  fi
else
  warn "curl not found. Network check skipped."
fi

ok "Preflight complete."
