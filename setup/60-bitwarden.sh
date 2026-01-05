#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

bash "$DOTFILES_DIR/secure/bw-session.sh"
