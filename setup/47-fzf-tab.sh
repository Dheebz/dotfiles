#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

if ! command -v git >/dev/null 2>&1; then
  warn "git not found. Install git first."
  exit 1
fi

target="$HOME/.zsh/plugins/fzf-tab"
if [[ -d "$target/.git" ]]; then
  info "fzf-tab already installed at $target"
  exit 0
fi

mkdir -p "$(dirname "$target")"
run_cmd "fzf-tab-clone" git clone --depth 1 https://github.com/Aloxaf/fzf-tab "$target"
ok "fzf-tab installed"
