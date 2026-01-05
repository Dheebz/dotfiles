#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"
source "$(dirname "${BASH_SOURCE[0]}")/46-npm-lsp.sh"

if ! command -v brew &>/dev/null; then
  warn "Homebrew not found. Run setup/30-homebrew.sh first."
  exit 1
fi

if [[ ! -f "$DOTFILES_DIR/macos/Brewfile" ]]; then
  warn "Missing Brewfile at macos/Brewfile."
  exit 1
fi

info "Installing required software from Brewfile..."
note "This can take a while. Use --verbose to stream output."

# Print what will be installed (brew/cask/tap)
while read -r type name _; do
  case "$type" in
    brew|cask|tap)
      info "Installing $type: $name"
      ;;
  esac
done < <(grep -E '^(brew|cask|tap) ' "$DOTFILES_DIR/macos/Brewfile")

bundle_args=(--file "$DOTFILES_DIR/macos/Brewfile")
if [[ "$(uname -s)" == "Linux" ]]; then
  bundle_args+=(--no-cask)
fi

brew bundle "${bundle_args[@]}"

info "Installing npm language servers..."
install_npm_lsps
