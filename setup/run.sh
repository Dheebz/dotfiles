#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

case "$(uname -s)" in
  Darwin) OS_TYPE="macos" ;;
  Linux) OS_TYPE="linux" ;;
  *) OS_TYPE="unknown" ;;
esac

parse_args "$@"

WIZARD_RAN=false
if ! $ASSUME_YES && ! $NO_WIZARD; then
  maybe_run_wizard
  WIZARD_RAN=true
fi

STREAM_SCRIPTS=(
  "30-homebrew.sh"
  "40-brew-bundle.sh"
  "45-helix-devtools.sh"
)

SCRIPTS=(
  "00-preflight.sh:macos:ALWAYS"
  "01-preflight-linux.sh:linux:ALWAYS"
  "10-computer-name.sh:all:HOSTNAME"
  "20-xcode.sh:macos:XCODE"
  "30-homebrew.sh:all:HOMEBREW"
  "40-brew-bundle.sh:all:BREWS"
  "45-helix-devtools.sh:all:DEVTOOLS"
  "47-fzf-tab.sh:all:DOTFILES"
  "50-symlinks.sh:all:DOTFILES"
  "55-git-identity.sh:all:DOTFILES"
  "60-bitwarden.sh:all:SECURE"
  "65-env.sh:all:SECURE"
  "70-ssh.sh:all:SECURE"
  "75-tweaks.sh:macos:TWEAKS"
  "77-karabiner.sh:macos:KARABINER"
  "80-ui.sh:macos:UI"
  "90-cleanup.sh:macos:ALWAYS"
)

for entry in "${SCRIPTS[@]}"; do
  script="${entry%%:*}"
  scope="${entry#*:}"
  scope="${scope%%:*}"
  gate="${entry##*:}"

  if [[ "$scope" != "all" && "$scope" != "$OS_TYPE" ]]; then
    info "Skipping setup/$script (not for $OS_TYPE)"
    continue
  fi

  if [[ "$gate" != "ALWAYS" ]] && ! want_step "$gate"; then
    info "Skipping setup/$script (disabled)"
    continue
  fi

  should_stream=false
  for stream in "${STREAM_SCRIPTS[@]}"; do
    if [[ "$script" == "$stream" ]]; then
      should_stream=true
      break
    fi
  done

  if $ASSUME_YES || $WIZARD_RAN; then
    if $should_stream; then
      prev_verbose=$VERBOSE
      VERBOSE=true
      run_step "$script" bash "$DOTFILES_DIR/setup/$script"
      VERBOSE=$prev_verbose
    else
      run_step "$script" bash "$DOTFILES_DIR/setup/$script"
    fi
  else
    if confirm "Run setup/$script?"; then
      if $should_stream; then
        prev_verbose=$VERBOSE
        VERBOSE=true
        run_step "$script" bash "$DOTFILES_DIR/setup/$script"
        VERBOSE=$prev_verbose
      else
        run_step "$script" bash "$DOTFILES_DIR/setup/$script"
      fi
    else
      info "Skipping setup/$script"
    fi
  fi
done

ok "Setup complete."
