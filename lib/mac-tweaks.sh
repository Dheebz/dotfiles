#!/usr/bin/env bash
set -euo pipefail

macos_tweaks() {
  defaults write -g ApplePressAndHoldEnabled -bool false
  defaults write -g KeyRepeat -int 2
  defaults write -g InitialKeyRepeat -int 15
  defaults write -g AppleShowAllExtensions -bool true
  killall Finder >/dev/null 2>&1 || true
}
