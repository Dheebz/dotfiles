# ~/.zsh/00-env.zsh
# Core environment setup and path configuration

# Load Homebrew paths
if command -v brew >/dev/null 2>&1; then
  eval "$(brew shellenv)"
fi

# PATH prepending
export PATH="$HOME/.local/bin:$PATH"

# Workspace setup
export WORKSPACE="$HOME/Workspace"
mkdir -p "$WORKSPACE"
alias cwork='cd "$WORKSPACE"'

# Editor
export EDITOR="hx"

# Brew prefix fallback
BREW_PREFIX="$(brew --prefix 2>/dev/null || echo /opt/homebrew)"

# LLVM (clangd/clang-format) path for Helix
if command -v brew >/dev/null 2>&1; then
  llvm_prefix="$(brew --prefix llvm 2>/dev/null || true)"
  if [ -n "$llvm_prefix" ] && [ -d "$llvm_prefix/bin" ]; then
    export PATH="$llvm_prefix/bin:$PATH"
  fi
fi

# GOPATH and GOBIN
export GOPATH="${GOPATH:-$HOME/go}"
export GOBIN="$GOPATH/bin"
mkdir -p "$GOBIN"

# PATH additions for tools
export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$HOME/.bun/bin:$HOME/.cargo/bin:$GOBIN:$PATH"

# NPM prefix
if command -v npm >/dev/null 2>&1; then
  npm_prefix="$(npm config get prefix 2>/dev/null || true)"
  if [ -n "$npm_prefix" ]; then
    export PATH="$npm_prefix/bin:$PATH"
  fi
fi

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Prevent Python from writing .pyc files
export PYTHONDONTWRITEBYTECODE=1
