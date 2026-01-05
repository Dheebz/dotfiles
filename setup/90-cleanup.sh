#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

info "Cleaning up setup logs..."
if [[ -d "$LOG_DIR" ]]; then
  rm -f "$LOG_DIR"/*.log >/dev/null 2>&1 || true
fi

if confirm "Remove dockutil (if installed for Dock config)?"; then
  source "$(dirname "${BASH_SOURCE[0]}")/80-ui.sh"
  cleanup_dockutil || true
fi

ok "Cleanup complete."
