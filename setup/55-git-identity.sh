#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

if ! command -v git >/dev/null 2>&1; then
  warn "git not found. Run setup/30-homebrew.sh first."
  exit 1
fi

name="$(git config --global --get user.name || true)"
email="$(git config --global --get user.email || true)"

if [[ -z "$name" ]]; then
  if confirm "Set git user.name?"; then
    if [[ -r /dev/tty ]]; then
      read -r -p "git user.name: " name </dev/tty
    else
      read -r -p "git user.name: " name
    fi
    [[ -n "$name" ]] && git config --global user.name "$name"
  fi
fi

if [[ -z "$email" ]]; then
  if confirm "Set git user.email?"; then
    if [[ -r /dev/tty ]]; then
      read -r -p "git user.email: " email </dev/tty
    else
      read -r -p "git user.email: " email
    fi
    [[ -n "$email" ]] && git config --global user.email "$email"
  fi
fi

name="$(git config --global --get user.name || true)"
email="$(git config --global --get user.email || true)"

if [[ -n "$name" && -n "$email" ]]; then
  ok "git identity configured: $name <$email>"
else
  warn "git identity incomplete. user.name or user.email missing."
fi
