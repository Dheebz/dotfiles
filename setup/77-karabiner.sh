#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

require_macos

if ! command -v brew >/dev/null 2>&1; then
  warn "Homebrew not found. Run setup/30-homebrew.sh first."
  exit 1
fi

if ! brew list --cask karabiner-elements >/dev/null 2>&1; then
  info "Installing Karabiner-Elements..."
  brew install --cask karabiner-elements
else
  info "Karabiner-Elements already installed."
fi

config_src="$DOTFILES_DIR/common/karabiner/karabiner.json"
config_dir="$HOME/.config/karabiner"
config_dst="$config_dir/karabiner.json"

if [[ -f "$config_src" ]]; then
  info "Linking Karabiner config..."
  mkdir -p "$config_dir"
  ln -sf "$config_src" "$config_dst"
else
  warn "No Karabiner config found at common/karabiner/karabiner.json"
fi

app_path="/Applications/Karabiner-Elements.app"
if [[ -d "$app_path" ]]; then
  /usr/bin/osascript <<'AS' >/dev/null 2>&1 || warn "Failed to set login item for Karabiner-Elements"
tell application "System Events"
  if not (exists login item "Karabiner-Elements") then
    make login item at end with properties {path:"/Applications/Karabiner-Elements.app", hidden:false}
  end if
end tell
AS
else
  warn "Karabiner-Elements app not found at $app_path"
fi

info "Karabiner-Elements setup complete."
