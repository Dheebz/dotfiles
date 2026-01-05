# Ensure toolchain bins stay on PATH even if other tools modify it.

path_prepend() {
  case ":$PATH:" in
    *":$1:"*) ;;
    *) export PATH="$1:$PATH" ;;
  esac
}

if [ -d "$HOME/.cargo/bin" ]; then
  path_prepend "$HOME/.cargo/bin"
fi

if command -v brew >/dev/null 2>&1; then
  llvm_prefix="$(brew --prefix llvm 2>/dev/null || true)"
  if [ -n "$llvm_prefix" ] && [ -d "$llvm_prefix/bin" ]; then
    path_prepend "$llvm_prefix/bin"
  fi
fi

if command -v rustup >/dev/null 2>&1; then
  active_toolchain="$(rustup show active-toolchain 2>/dev/null | awk '{print $1}')"
  if [ -n "$active_toolchain" ]; then
    toolchain_bin="$HOME/.rustup/toolchains/$active_toolchain/bin"
    if [ -d "$toolchain_bin" ]; then
      path_prepend "$toolchain_bin"
    fi
  fi
fi
