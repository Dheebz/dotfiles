#!/usr/bin/env bash
set -euo pipefail

install_rust() {
  command -v rustc >/dev/null 2>&1 && return 0
  curl https://sh.rustup.rs -sSf | sh -s -- -y
}

install_bun() {
  command -v bun >/dev/null 2>&1 && return 0
  curl -fsSL https://bun.sh/install | bash
}

install_devtools_bundle() {
  install_rust
  install_bun
}
