#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB="$SCRIPT_DIR/lib"

# shellcheck source=lib/common.sh
source "$LIB/common.sh"
# shellcheck source=lib/mac-ui.sh
source "$LIB/mac-ui.sh"

main() {
  require_macos
  parse_args "$@"  # so you can still use --yes etc if you want

  section "Cleanup"
  note "Backups directory: $BACKUP_DIR"

  # Add more cleanup calls here over time:
  run_step "Remove dockutil (if installed)" cleanup_dockutil

  ok "Cleanup complete"
}

main "$@"
