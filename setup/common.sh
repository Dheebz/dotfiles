#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# ---------- env bootstrap ----------
load_homebrew_env() {
  command -v brew >/dev/null 2>&1 && return 0

  local candidates=(
    "/opt/homebrew/bin/brew"
    "/usr/local/bin/brew"
    "/home/linuxbrew/.linuxbrew/bin/brew"
  )
  for candidate in "${candidates[@]}"; do
    if [[ -x "$candidate" ]]; then
      eval "$("$candidate" shellenv)"
      return 0
    fi
  done

  return 1
}

load_homebrew_env || true

# ---------- pretty output ----------
c_blue="\033[1;34m"; c_yellow="\033[1;33m"; c_green="\033[1;32m"; c_red="\033[1;31m"; c_dim="\033[2m"; c_reset="\033[0m"
info()  { printf "${c_blue}==> %s${c_reset}\n" "$*"; }
ok()    { printf "${c_green}OK  %s${c_reset}\n" "$*"; }
warn()  { printf "${c_yellow}WARN %s${c_reset}\n" "$*"; }
fail()  { printf "${c_red}FAIL %s${c_reset}\n" "$*"; }
note()  { printf "${c_dim}%s${c_reset}\n" "$*"; }

section() {
  echo
  info "$1"
  note "--------------------------------------------"
}

# ---------- defaults / globals ----------
ASSUME_YES=false
VERBOSE=false
NO_WIZARD=false

CACHE_DIR="${CACHE_DIR:-$DOTFILES_DIR/.cache}"
BACKUP_DIR="${BACKUP_DIR:-$CACHE_DIR/mac_config_backup_$(date +%s)}"
LOG_DIR="${LOG_DIR:-$BACKUP_DIR/logs}"
mkdir -p "$BACKUP_DIR" "$LOG_DIR" >/dev/null 2>&1 || true

WANT_XCODE=true
WANT_HOSTNAME=true
WANT_HOMEBREW=true
WANT_BREWS=true
WANT_DEVTOOLS=true
WANT_TWEAKS=true
WANT_KARABINER=true
WANT_SECURE=true
WANT_DOTFILES=true
WANT_UI=true

SKIP_DOCK=false
SKIP_FINDER=false

# ---------- prompts ----------
confirm() {
  local prompt="${1:-Continue?}"
  if $ASSUME_YES; then
    ok "$prompt (auto-yes)"
    return 0
  fi
  if [[ -r /dev/tty ]]; then
    read -r -p "$prompt [y/N]: " ans </dev/tty
  else
    read -r -p "$prompt [y/N]: " ans
  fi
  [[ "${ans:-}" =~ ^[Yy]$ ]]
}

# ---------- platform/sudo ----------
require_macos() {
  [[ "$(uname -s)" == "Darwin" ]] || { fail "This script is for macOS only."; exit 1; }
}

ensure_sudo_if_needed() {
  local needs=false
  $WANT_HOSTNAME && needs=true
  $WANT_TWEAKS && needs=true

  $needs || return 0

  if sudo -n true 2>/dev/null; then
    return 0
  fi

  info "Some steps require sudo."
  confirm "Authenticate now?" && sudo -v || warn "Continuing without sudo (some steps may fail)"
}

# ---------- step gating ----------
want_step() {
  case "$1" in
    XCODE)     $WANT_XCODE ;;
    HOSTNAME)  $WANT_HOSTNAME ;;
    HOMEBREW)  $WANT_HOMEBREW ;;
    BREWS)     $WANT_BREWS ;;
    DEVTOOLS)  $WANT_DEVTOOLS ;;
    TWEAKS)    $WANT_TWEAKS ;;
    KARABINER) $WANT_KARABINER ;;
    SECURE)    $WANT_SECURE ;;
    DOTFILES)  $WANT_DOTFILES ;;
    UI)        $WANT_UI ;;
    *) return 1 ;;
  esac
}

# ---------- quieter command runner ----------
_slugify() {
  echo "$1" | tr ' /' '__' | tr -cd '[:alnum:]_:-'
}

run_cmd() {
  local title="$1"; shift
  local log_file="$LOG_DIR/$(_slugify "$title").log"

  if $VERBOSE; then
    "$@"
    return $?
  fi

  note "Logging to $log_file (use --verbose to stream output)"
  if "$@" >"$log_file" 2>&1; then
    return 0
  fi

  warn "Command failed: $title"
  warn "Showing last 30 lines of log:"
  tail -n 30 "$log_file" || true
  warn "Full log: $log_file"
  return 1
}

run_step() {
  local title="$1"; shift
  section "$title"
  if run_cmd "$title" "$@"; then
    ok "$title done"
  else
    warn "$title completed with warnings"
  fi
}

# ---------- args ----------
parse_args() {
  for arg in "$@"; do
    case "$arg" in
      --yes|-y) ASSUME_YES=true ;;

      --verbose|-v) VERBOSE=true ;;
      --quiet|-q) VERBOSE=false ;;

      --no-wizard) NO_WIZARD=true ;;

      --no-xcode) WANT_XCODE=false ;;
      --no-hostname) WANT_HOSTNAME=false ;;
      --no-homebrew) WANT_HOMEBREW=false ;;
      --no-brews) WANT_BREWS=false ;;
      --no-devtools) WANT_DEVTOOLS=false ;;
      --no-tweaks) WANT_TWEAKS=false ;;
      --no-karabiner) WANT_KARABINER=false ;;
      --no-secure) WANT_SECURE=false ;;
      --no-dotfiles) WANT_DOTFILES=false ;;
      --no-ui) WANT_UI=false ;;

      --no-dock) SKIP_DOCK=true ;;
      --no-finder) SKIP_FINDER=true ;;

      *) warn "Unknown flag: $arg" ;;
    esac
  done

  $WANT_UI || { SKIP_DOCK=true; SKIP_FINDER=true; }
}

# ---------- wizard ----------
maybe_run_wizard() {
  $ASSUME_YES && return 0

  section "Welcome"
  note "Interactive setup — you can re-run anytime."
  note "Default output is quiet. Use --verbose to see full command output."
  echo

  confirm "Install Xcode CLT?"                       || WANT_XCODE=false
  confirm "Set hostname?"                            || WANT_HOSTNAME=false
  confirm "Install Homebrew?"                        || WANT_HOMEBREW=false
  confirm "Install brew packages/apps/fonts?"        || WANT_BREWS=false
  confirm "Install dev tools?"                       || WANT_DEVTOOLS=false
  confirm "Apply macOS tweaks?"                      || WANT_TWEAKS=false
  confirm "Configure Karabiner?"                     || WANT_KARABINER=false
  confirm "Load SSH + PGP keys (drop into .secure)?" || WANT_SECURE=false
  confirm "Link dotfiles?"                           || WANT_DOTFILES=false
  confirm "Configure UI?"                            || WANT_UI=false

  $WANT_UI || { SKIP_DOCK=true; SKIP_FINDER=true; }
}
