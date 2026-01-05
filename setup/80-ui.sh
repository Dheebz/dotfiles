#!/usr/bin/env bash
set -euo pipefail

# Uses globals from common.sh:
#   BACKUP_DIR
#   SKIP_DOCK, SKIP_FINDER
#
# Provides:
#   ui_main
#   cleanup_dockutil  (called by bootstrap cleanup)

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

backup_if_exists() {
  local p="$1"
  [[ -e "$p" ]] || return 0
  info "Backing up $p -> $BACKUP_DIR/"
  mv "$p" "$BACKUP_DIR/" || warn "Failed backup: $p"
}

clear_widgets() {
  info "Clearing Notification Center widgets..."
  backup_if_exists "$HOME/Library/Group Containers/widgetkit"
  backup_if_exists "$HOME/Library/Preferences/com.apple.widgetpreferences.plist"
  killall NotificationCenter >/dev/null 2>&1 || true
  sleep 1
}

ensure_dockutil() {
  command -v dockutil >/dev/null 2>&1 && return 0

  if command -v brew >/dev/null 2>&1; then
    info "Installing dockutil..."
    brew install dockutil || { warn "dockutil install failed"; return 1; }
    return 0
  fi

  warn "Homebrew not found; dockutil unavailable. Dock config may be skipped."
  return 1
}

configure_dock() {
  info "Configuring Dock..."

  if ensure_dockutil; then
    dockutil --remove all --no-restart || warn "dockutil remove failed"

    local apps=(
      "/Applications/WezTerm.app"
      "/Applications/Google Chrome.app"
      "/Applications/Visual Studio Code.app"
      "/Applications/Spotify.app"
      "$HOME/Applications/WezTerm.app"
    )

    for a in "${apps[@]}"; do
      [[ -d "$a" ]] && dockutil --add "$a" --no-restart || true
    done
  fi

  defaults write com.apple.dock orientation -string right
  defaults write com.apple.dock tilesize -int 33
  defaults write com.apple.dock autohide -bool true
  killall Dock >/dev/null 2>&1 || true
  sleep 1
}

pin_workspace_finder() {
  local dir="$HOME/Workspace"
  [[ -d "$dir" ]] || { info "$dir not found; skipping Finder pin"; return 0; }

  info "Adding $dir to Finder sidebar..."
  /usr/bin/osascript <<AS >/dev/null 2>&1 || warn "Finder automation failed"
tell application "Finder"
  activate
  try
    set theFolder to POSIX file "${dir}" as alias
    open theFolder
  end try
end tell
delay 0.4
tell application "System Events"
  tell process "Finder"
    try
      click menu item "Add to Sidebar" of menu "File" of menu bar 1
    end try
  end tell
end tell
AS
}

cleanup_dockutil() {
  command -v brew >/dev/null 2>&1 || return 0
  command -v dockutil >/dev/null 2>&1 || return 0

  info "Removing dockutil (cleanup)..."
  brew uninstall --force --ignore-dependencies dockutil >/dev/null 2>&1 \
    || brew remove dockutil >/dev/null 2>&1 \
    || warn "Failed to remove dockutil"
}

ui_main() {
  clear_widgets

  $SKIP_DOCK || configure_dock
  $SKIP_FINDER || pin_workspace_finder
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  ui_main
fi
