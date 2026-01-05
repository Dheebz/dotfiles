#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"
source "$(dirname "${BASH_SOURCE[0]}")/46-npm-lsp.sh"

if ! command -v brew &>/dev/null; then
  warn "Homebrew not found. Run setup/30-homebrew.sh first."
  exit 1
fi

if ! command -v npm &>/dev/null; then
  warn "npm not found. Install Node.js first (Brewfile includes it)."
fi

brew_tools=(
  ty
  ruff
  rustup
  rust-analyzer
  go
  gopls
  llvm
  lua-language-server
  marksman
  taplo
  texlab
  svls
  stylua
  shfmt
  prettier
  node
  elixir
  elixir-ls
)

info "Installing Helix tooling (LSPs/formatters/debuggers)..."
note "This can take a while. Use --verbose to stream output."
run_cmd "brew-helix-tools" brew install "${brew_tools[@]}"

install_npm_lsps

if command -v rustup &>/dev/null; then
  run_cmd "rustup-default-stable" rustup default stable
  run_cmd "rustup-rustfmt" rustup component add rustfmt
fi

# Ensure clang-format is on PATH when LLVM is installed.
if command -v brew &>/dev/null; then
  llvm_prefix="$(brew --prefix llvm 2>/dev/null || true)"
  if [ -n "$llvm_prefix" ] && [ -d "$llvm_prefix/bin" ]; then
    export PATH="$llvm_prefix/bin:$PATH"
  fi
fi

if command -v hx &>/dev/null; then
  info "Helix health checks..."
  hx --health python rust go cpp c json yaml bash typescript javascript tsx jsx elixir heex docker-compose || true
fi
