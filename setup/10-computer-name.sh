#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

if [[ -r /dev/tty ]]; then
  read -r -p "Enter the new computer name: " name </dev/tty
else
  read -r -p "Enter the new computer name: " name
fi
if [[ -z "$name" ]]; then
  info "Empty name entered. Skipping."
  exit 0
fi

case "$(uname -s)" in
  Darwin)
    sudo scutil --set ComputerName "$name"
    sudo scutil --set HostName "$name"
    sudo scutil --set LocalHostName "$name"
    ;;
  Linux)
    if command -v hostnamectl >/dev/null 2>&1; then
      sudo hostnamectl set-hostname "$name"
    else
      warn "hostnamectl not found. Skipping hostname update."
      exit 0
    fi
    ;;
  *)
    warn "Unsupported OS. Skipping hostname update."
    exit 0
    ;;
esac

info "Computer name updated to: $name"
