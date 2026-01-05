#!/usr/bin/env bash
set -euo pipefail

# Shared npm LSP install helpers. Source after common.sh.

NPM_LSP_TOOLS=(
  bash-language-server
  typescript
  typescript-language-server
  yaml-language-server
  vscode-langservers-extracted
  dockerfile-language-server-nodejs
)

install_npm_lsps() {
  local marker
  marker="${NPM_LSP_MARKER:-$CACHE_DIR/npm_lsp_tools_installed}"
  if command -v npm &>/dev/null; then
    if [[ -f "$marker" ]]; then
      info "npm LSPs already installed. Skipping."
    else
      run_cmd "npm-lsp-tools" npm install -g "${NPM_LSP_TOOLS[@]}"
      mkdir -p "$CACHE_DIR" >/dev/null 2>&1 || true
      touch "$marker" >/dev/null 2>&1 || true
    fi
  else
    warn "npm not found. Skipping npm LSP installs (install Node.js and re-run)."
  fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  source "$(dirname "${BASH_SOURCE[0]}")/common.sh"
  install_npm_lsps
fi
