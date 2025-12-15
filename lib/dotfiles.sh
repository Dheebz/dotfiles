#!/usr/bin/env bash
set -euo pipefail

# Expects these from lib/common.sh:
# - info / warn / note
# - BACKUP_DIR
#
# Optional env vars:
# - DOTFILES_REPO   (e.g. Dheebz/dotfiles or full git URL)
# - DOTFILES_TARGET (default: ~/.dotfiles)

DOTFILES_REPO="${DOTFILES_REPO:-}"                 # if empty -> link from local repo
DOTFILES_TARGET="${DOTFILES_TARGET:-$HOME/.dotfiles}"

DOTFILES_ITEMS=(
  .zshrc
  .wezterm.lua
  .config
  .gitconfig
  .gitignore_global
)

repo_root() {
  # lib/ is one level down from repo root
  cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd
}

gh_auth_check() {
  command -v gh >/dev/null 2>&1 && gh auth status >/dev/null 2>&1
}

backup_then_link() {
  local src="$1"
  local dest="$2"

  [[ -e "$src" ]] || { warn "Missing source: $src"; return 0; }

  # Already correctly linked?
  if [[ -L "$dest" ]] && [[ "$(readlink "$dest")" == "$src" ]]; then
    note "Already linked: $dest"
    return 0
  fi

  # Backup existing dest
  if [[ -e "$dest" || -L "$dest" ]]; then
    mkdir -p "$BACKUP_DIR"
    info "Backing up $dest -> $BACKUP_DIR/"
    mv "$dest" "$BACKUP_DIR/" || warn "Failed to backup $dest"
  fi

  mkdir -p "$(dirname "$dest")"
  ln -sfn "$src" "$dest" || warn "Failed linking $dest"
  note "Linked: $dest -> $src"
}

clone_or_update_dotfiles_repo() {
  [[ -n "$DOTFILES_REPO" ]] || return 0

  if [[ -d "$DOTFILES_TARGET/.git" ]]; then
    info "Updating dotfiles repo: $DOTFILES_TARGET"
    (cd "$DOTFILES_TARGET" && git pull --rebase) || warn "Failed updating dotfiles repo"
    return 0
  fi

  info "Cloning dotfiles repo -> $DOTFILES_TARGET"

  # Try gh first if authenticated (nice for private repos), then fallback to git clone
  if gh_auth_check; then
    gh repo clone "$DOTFILES_REPO" "$DOTFILES_TARGET" || true
  fi

  if [[ ! -d "$DOTFILES_TARGET/.git" ]]; then
    local url
    if [[ "$DOTFILES_REPO" == https://* || "$DOTFILES_REPO" == git@* ]]; then
      url="$DOTFILES_REPO"
    else
      url="https://github.com/$DOTFILES_REPO.git"
    fi

    git clone "$url" "$DOTFILES_TARGET" || { warn "Failed cloning $url"; return 1; }
  fi
}

link_from_target_dir() {
  local target_dir="$1"
  info "Linking dotfiles from: $target_dir"

  for item in "${DOTFILES_ITEMS[@]}"; do
    local src="$target_dir/$item"
    local dest="$HOME/$item"

    # Special case: .config should land at ~/.config (same path, but ensure dir exists)
    if [[ "$item" == ".config" ]]; then
      dest="$HOME/.config"
    fi

    backup_then_link "$src" "$dest"
  done
}

set_global_gitignore() {
  local gfile="$HOME/.gitignore_global"

  if [[ -e "$gfile" ]]; then
    local current
    current="$(git config --global core.excludesfile 2>/dev/null || true)"
    if [[ "$current" != "$gfile" ]]; then
      info "Setting git global excludesfile -> $gfile"
      git config --global core.excludesfile "$gfile" || warn "Failed to set core.excludesfile"
    else
      note "git excludesfile already set"
    fi
  else
    note "No ~/.gitignore_global found; skipping git excludesfile"
  fi
}

dotfiles_main() {
  # Decide mode
  if [[ -n "$DOTFILES_REPO" ]]; then
    clone_or_update_dotfiles_repo || return 0
    link_from_target_dir "$DOTFILES_TARGET"
  else
    local local_root
    local_root="$(repo_root)"
    link_from_target_dir "$local_root"
  fi

  set_global_gitignore || true
}

