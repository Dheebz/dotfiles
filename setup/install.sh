#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${REPO_URL:-https://github.com/Dheebz/dotfiles.git}"
TARGET_DIR="${TARGET_DIR:-$HOME/dotfiles}"

log() {
  printf "%s\n" "$*"
}

ensure_git() {
  if command -v git >/dev/null 2>&1; then
    return 0
  fi

  log "git not found. Installing Xcode Command Line Tools..."
  xcode-select --install || true
  log "Complete the Xcode install dialog, then press Enter to continue."
  if [[ -r /dev/tty ]]; then
    read -r </dev/tty
  else
    read -r
  fi

  until command -v git >/dev/null 2>&1; do
    log "Waiting for git to become available..."
    sleep 10
  done
}

clone_or_update_repo() {
  if [[ -d "$TARGET_DIR/.git" ]]; then
    log "Updating existing repo at $TARGET_DIR..."
    git -C "$TARGET_DIR" pull --rebase
    return 0
  fi

  if [[ -e "$TARGET_DIR" ]]; then
    log "Target exists but is not a git repo: $TARGET_DIR"
    exit 1
  fi

  log "Cloning $REPO_URL to $TARGET_DIR..."
  git clone "$REPO_URL" "$TARGET_DIR"
}

main() {
  ensure_git

  clone_or_update_repo
  log "Running setup..."
  bash "$TARGET_DIR/setup/run.sh" "$@"
}

main "$@"
