#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

if ! command -v bw &>/dev/null; then
  warn "Bitwarden CLI (bw) not installed. Run setup/40-brew-bundle.sh first."
  exit 1
fi

info "Importing SSH keys from Bitwarden..."
bash "$DOTFILES_DIR/secure/ssh-import.sh"
