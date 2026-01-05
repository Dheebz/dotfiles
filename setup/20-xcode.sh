#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

require_macos

if xcode-select -p &>/dev/null; then
  info "Xcode Command Line Tools already installed."
  exit 0
fi

info "Installing Xcode Command Line Tools..."
xcode-select --install || true
info "Complete the Xcode install dialog, then press Enter to continue."
if [[ -r /dev/tty ]]; then
  read -r </dev/tty
else
  read -r
fi

until xcode-select -p &>/dev/null; do
  info "Waiting for Xcode Command Line Tools to finish installing..."
  sleep 10
done
