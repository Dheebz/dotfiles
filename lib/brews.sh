#!/usr/bin/env bash
set -euo pipefail

BREW_PACKAGES=(fzf ripgrep fd wget htop neovim git gh starship bat zoxide)
BREW_CASKS=(wezterm google-chrome docker visual-studio-code spotify)
BREW_FONTS=(font-jetbrains-mono-nerd-font)

install_brews() {
  brew update || true
  brew tap homebrew/cask-fonts >/dev/null 2>&1 || true

  for p in "${BREW_PACKAGES[@]}"; do
    brew list "$p" >/dev/null 2>&1 || brew install "$p"
  done

  for c in "${BREW_CASKS[@]}"; do
    brew list --cask "$c" >/dev/null 2>&1 || brew install --cask "$c"
  done

  for f in "${BREW_FONTS[@]}"; do
    brew list --cask "$f" >/dev/null 2>&1 || brew install --cask "$f"
  done
}
