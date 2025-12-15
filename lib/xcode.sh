#!/usr/bin/env bash
set -euo pipefail

install_xcode_clt() {
  if pkgutil --pkg-info=com.apple.pkg.CLTools_Executables >/dev/null 2>&1; then
    info "Xcode CLT already installed."
    return 0
  fi

  info "Installing Xcode Command Line Tools..."
  xcode-select --install || true
  until pkgutil --pkg-info=com.apple.pkg.CLTools_Executables >/dev/null 2>&1; do
    sleep 5
  done
}
