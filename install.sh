#!/usr/bin/env bash
#
# Bootstrap & install dotfiles in one go.
#
# - Installs Xcode Command Line Tools
# - Installs Homebrew
# - Installs CLI tools & GUI apps
# - Installs fonts
# - Creates ~/Workspace
# - Symlinks dotfiles into $HOME / ~/.config
#
# Usage:
#   ./install.sh             # full bootstrap + symlinks + Workspace
#   ./install.sh --link-only # only create/update symlinks + Workspace
#   ./install.sh --brew-only # only install tools (no symlinks, still makes Workspace)

set -euo pipefail

# ---------------------------------------
# Configuration
# ---------------------------------------

# Packages installed via Homebrew formulae
CLI_PACKAGES=(
  fzf
  ripgrep
  fd
  wget
  htop
  neovim
  tree
  git
  gh
  starship
  gnupg
  pinentry-mac
  node
  uv
  act
)

# GUI apps installed via Homebrew casks
CASK_PACKAGES=(
  wezterm
  google-chrome
  spotify
)

# Fonts (via homebrew/cask-fonts tap)
FONT_CASKS=(
  font-jetbrains-mono-nerd-font
)

# Where the dotfiles repo lives
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="${DOTFILES_DIR:-$REPO_DIR}"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

# ---------------------------------------
# Helpers & guards
# ---------------------------------------

if [ "${EUID:-$(id -u)}" -eq 0 ]; then
  echo "Don't run this as root/sudo. Run as your normal user."
  exit 1
fi

log()   { printf "\033[1;32m[+]\033[0m %s\n" "$*"; }
warn()  { printf "\033[1;33m[!]\033[0m %s\n" "$*"; }
error() { printf "\033[1;31m[x]\033[0m %s\n" "$*" >&2; }

usage() {
  cat <<EOF
Usage: $(basename "$0") [--link-only | --brew-only]

No args      : Install tools (brew, packages, casks, fonts) + create symlinks + ~/Workspace
--link-only  : Only create/update symlinks + ~/Workspace
--brew-only  : Only install tools (brew, packages, casks, fonts) + ~/Workspace
EOF
}

MODE="all"
if [ "${1:-}" = "--link-only" ]; then
  MODE="link-only"
elif [ "${1:-}" = "--brew-only" ]; then
  MODE="brew-only"
elif [ "${1:-}" != "" ]; then
  usage
  exit 1
fi

# ---------------------------------------
# Xcode Command Line Tools
# ---------------------------------------

ensure_xcode_clt() {
  log "Checking for Xcode Command Line Tools..."

  if xcode-select -p >/dev/null 2>&1; then
    log "Xcode Command Line Tools already installed: $(xcode-select -p)"
    return
  fi

  log "Xcode Command Line Tools not found. Triggering installer..."
  xcode-select --install || true

  cat <<'EOF'

A macOS pop-up should have appeared asking to install the
"Command Line Tools for Xcode".

  1. Click "Install"
  2. Accept the license
  3. Wait for the installation to finish

This script will keep checking every 20 seconds until the tools appear.

EOF

  while ! xcode-select -p >/dev/null 2>&1; do
    log "Waiting for Xcode Command Line Tools to finish installing..."
    sleep 20
  done

  log "Xcode Command Line Tools installed: $(xcode-select -p)"
}

# ---------------------------------------
# Homebrew & packages
# ---------------------------------------

ensure_homebrew() {
  log "Checking for Homebrew..."

  if command -v brew >/dev/null 2>&1; then
    log "Homebrew already installed at: $(command -v brew)"
  else
    log "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  local brew_bin=""
  if [ -x "/opt/homebrew/bin/brew" ]; then
    brew_bin="/opt/homebrew/bin/brew"
  elif [ -x "/usr/local/bin/brew" ]; then
    brew_bin="/usr/local/bin/brew"
  else
    brew_bin="$(command -v brew)"
  fi

  if [ -z "$brew_bin" ]; then
    error "Homebrew installation appears to have failed (brew not found on PATH)."
    exit 1
  fi

  eval "$("$brew_bin" shellenv)"

  # Persist to the user's shell startup file
  local shell_name rc_file brew_init
  shell_name="$(basename "${SHELL:-/bin/zsh}")"

  case "$shell_name" in
    zsh)  rc_file="$HOME/.zprofile" ;;
    bash) rc_file="$HOME/.bash_profile" ;;
    *)    rc_file="$HOME/.profile" ;;
  esac

  brew_init='eval "$('"$brew_bin"' shellenv)"'

  if [ -f "$rc_file" ] && grep -Fq "$brew_init" "$rc_file"; then
    log "Homebrew shellenv already present in $rc_file"
  else
    log "Adding Homebrew shellenv to $rc_file"
    {
      echo ""
      echo "# Added by dotfiles/install.sh"
      echo "$brew_init"
    } >>"$rc_file"
  fi
}

install_cli_packages() {
  log "Installing CLI packages via Homebrew..."

  for pkg in "${CLI_PACKAGES[@]}"; do
    if brew list --formula "$pkg" >/dev/null 2>&1; then
      log "cli: $pkg (already installed)"
    else
      log "cli: installing $pkg"
      brew install "$pkg"
    fi
  done
}

install_cask_packages() {
  log "Installing GUI apps (casks)..."

  for cask in "${CASK_PACKAGES[@]}"; do
    if brew list --cask "$cask" >/dev/null 2>&1; then
      log "cask: $cask (already installed)"
    else
      log "cask: installing $cask"
      brew install --cask "$cask"
    fi
  done
}

install_font_casks() {
  log "Installing fonts..."

  if [ "${#FONT_CASKS[@]}" -eq 0 ]; then
    log "No font casks configured, skipping."
    return
  fi

  brew tap homebrew/cask-fonts >/dev/null 2>&1 || true

  for cask in "${FONT_CASKS[@]}"; do
    if brew list --cask "$cask" >/dev/null 2>&1; then
      log "font: $cask (already installed)"
    else
      log "font: installing $cask"
      brew install --cask "$cask"
    fi
  done
}

# ---------------------------------------
# Workspace directory QoL
# ---------------------------------------

ensure_workspace() {
  local ws="$HOME/Workspace"

  if [ -d "$ws" ]; then
    log "Workspace directory already exists at: $ws"
  else
    log "Creating workspace directory at: $ws"
    mkdir -p "$ws"
  fi
}

# ---------------------------------------
# Symlink logic
# ---------------------------------------

link() {
  local src="$1"
  local dest="$2"

  if [ ! -e "$src" ] && [ ! -L "$src" ]; then
    warn "Source does not exist, skipping: $src"
    return 0
  fi

  mkdir -p "$(dirname "$dest")"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    # Already correct symlink?
    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
      log "Already linked: $dest -> $src"
      return 0
    fi

    local backup="${dest}.backup.$(date +%Y%m%d%H%M%S)"
    warn "Backing up existing $dest to $backup"
    mv "$dest" "$backup"
  fi

  ln -sfn "$src" "$dest"
  log "Linked $dest -> $src"
}

create_symlinks() {
  if [ ! -d "$DOTFILES_DIR" ]; then
    error "DOTFILES_DIR does not exist: $DOTFILES_DIR"
    exit 1
  fi

  log "Using dotfiles from: $DOTFILES_DIR"
  log "Config directory: $CONFIG_DIR"

  # Shell / zsh
  if [ -f "$DOTFILES_DIR/shell/.zshrc" ]; then
    link "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"
  else
    warn "No shell/.zshrc found in dotfiles."
  fi

  # Neovim
  if [ -d "$DOTFILES_DIR/nvim" ]; then
    link "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"
  else
    warn "No nvim/ directory found in dotfiles."
  fi

  # WezTerm
  if [ -f "$DOTFILES_DIR/wezterm/.wezterm.lua" ]; then
    link "$DOTFILES_DIR/wezterm/.wezterm.lua" "$HOME/.wezterm.lua"
  else
    warn "No wezterm/.wezterm.lua found in dotfiles."
  fi

  # Starship
  if [ -f "$DOTFILES_DIR/starship/starship.toml" ]; then
    link "$DOTFILES_DIR/starship/starship.toml" "$CONFIG_DIR/starship.toml"
  else
    warn "No starship/starship.toml found in dotfiles."
  fi

  # Git config
  if [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
    link "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
  else
    warn "No git/.gitconfig found in dotfiles (that's fine if you haven't made one yet)."
  fi

  # Git global ignore
  if [ -f "$DOTFILES_DIR/git/.gitignore_global" ]; then
    link "$DOTFILES_DIR/git/.gitignore_global" "$HOME/.gitignore_global"
  else
    warn "No git/.gitignore_global found in dotfiles."
  fi
}

# ---------------------------------------
# Main
# ---------------------------------------

main() {
  case "$MODE" in
    all)
      ensure_xcode_clt
      ensure_homebrew
      install_cli_packages
      install_cask_packages
      install_font_casks
      ensure_workspace
      create_symlinks
      ;;
    brew-only)
      ensure_xcode_clt
      ensure_homebrew
      install_cli_packages
      install_cask_packages
      install_font_casks
      ensure_workspace
      ;;
    link-only)
      ensure_workspace
      create_symlinks
      ;;
  esac

  log "All done. Open a new shell and you should be using your dotfiles 🎉"
}

main "$@"

