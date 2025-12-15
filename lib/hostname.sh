#!/usr/bin/env bash
set -euo pipefail

# Uses:
#   SET_HOSTNAME env var (default: janus)
# Requires sudo.

set_hostname() {
  local target="${SET_HOSTNAME:-janus}"
  local current=""

  current="$(scutil --get HostName 2>/dev/null || true)"
  if [[ "$current" == "$target" ]]; then
    info "Hostname already set: $target"
    return 0
  fi

  info "Setting hostname to: $target"
  sudo scutil --set ComputerName "$target" || warn "Failed: ComputerName"
  sudo scutil --set HostName "$target" || warn "Failed: HostName"
  sudo scutil --set LocalHostName "$target" || warn "Failed: LocalHostName"
  sudo hostname "$target" || warn "Failed: hostname"
}
