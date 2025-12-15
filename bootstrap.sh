#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LIB="$SCRIPT_DIR/lib"

# Core UI + args + globals
# shellcheck source=lib/common.sh
source "$LIB/common.sh"

# Steps
# shellcheck source=lib/xcode.sh
source "$LIB/xcode.sh"
# shellcheck source=lib/hostname.sh
source "$LIB/hostname.sh"
# shellcheck source=lib/homebrew.sh
source "$LIB/homebrew.sh"
# shellcheck source=lib/brews.sh
source "$LIB/brews.sh"
# shellcheck source=lib/devtools.sh
source "$LIB/devtools.sh"
# shellcheck source=lib/mac-tweaks.sh
source "$LIB/mac-tweaks.sh"
# shellcheck source=lib/karabiner.sh
source "$LIB/karabiner.sh"
# shellcheck source=lib/secure.sh
source "$LIB/secure.sh"
# shellcheck source=lib/dotfiles.sh
source "$LIB/dotfiles.sh"
# shellcheck source=lib/mac-ui.sh
source "$LIB/mac-ui.sh"
# shellcheck source=lib/cleanup.sh
source "$LIB/cleanup.sh"

main() {
  require_macos
  parse_args "$@"
  maybe_run_wizard

  section "Preparation"
  note "Backups directory: $BACKUP_DIR"
  note "Logs directory:    $LOG_DIR"
  ensure_sudo_if_needed

  want_step XCODE     && run_step "1) Xcode Command Line Tools" install_xcode_clt
  want_step HOSTNAME  && run_step "2) Hostname" set_hostname
  want_step HOMEBREW  && run_step "3) Homebrew" install_homebrew
  want_step BREWS     && run_step "4) Brew packages/apps/fonts" install_brews
  want_step DEVTOOLS  && run_step "5) Dev tools" install_devtools_bundle
  want_step TWEAKS    && run_step "6) macOS tweaks" macos_tweaks
  want_step KARABINER && run_step "7) Karabiner caps mapping" configure_capslock_hyper

  # User drops keys into repo/.secure then script imports them
  want_step SECURE    && run_step "8) Secure keys (drop into .secure then load)" secure_main

  want_step DOTFILES  && run_step "9) Dotfiles" dotfiles_main
  want_step UI        && run_step "10) UI (widgets/dock/finder)" ui_main

  # Cleanup always last
  run_step "11) Cleanup" cleanup_main

  ok "🎉 Bootstrap complete!"
  note "Backups (if any): $BACKUP_DIR"
}

main "$@"
