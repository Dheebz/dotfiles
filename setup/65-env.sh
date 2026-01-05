#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

info "Importing environment secrets from Bitwarden..."
bash "$DOTFILES_DIR/secure/env-import.sh"
