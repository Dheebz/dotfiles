#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

require_macos

info "Applying macOS quality-of-life tweaks..."

# Key repeat behavior
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 15

# Finder visibility defaults
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

killall Finder >/dev/null 2>&1 || true

# Avoid creating .DS_Store files on network/USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Xcode: Show line numbers by default
defaults write com.apple.dt.Xcode ShowLineNumbers -bool true

# Always show ~/Library folder
chflags nohidden ~/Library

info "Tweaks applied."
