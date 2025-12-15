#!/usr/bin/env bash
set -euo pipefail

# Secure key pickup + load/import
#
# Default secure dir is: <repo-root>/.secure
# (repo root is the directory containing bootstrap.sh)
#
# Expected layout:
#   <repo>/.secure/
#     ssh/
#       <any-name>
#       <any-name>.pub
#     pgp/
#       <any-name>.asc   (or .gpg/.key/.pgp)
#
# Env vars:
#   SSH_KEY_NAME="github_ed25519"   (optional override; if unset, auto-detect)
#   SET_GIT_SIGNING=true|false      (default true)
#   SECURE_DIR="..."                (optional override)

SSH_KEY_NAME="${SSH_KEY_NAME:-}" # empty => auto-detect
SET_GIT_SIGNING="${SET_GIT_SIGNING:-true}"

repo_root() {
  cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd
}

# If SECURE_DIR not set, use repo root's .secure
SECURE_DIR="${SECURE_DIR:-"$(repo_root)/.secure"}"

# --- Logging helpers (in case this file is run standalone) ---
section() {
  echo
  echo "== $* =="
}
info() { echo "[INFO] $*"; }
ok() { echo "[ OK ] $*"; }
note() { echo "[NOTE] $*"; }
warn() { echo "[WARN] $*" >&2; }

# If run_step exists in your bootstrap framework, use it; otherwise fall back
run_step() {
  local title="$1"
  shift
  section "$title"
  "$@"
}
# ------------------------------------------------------------

secure_init_dirs() {
  mkdir -p "$SECURE_DIR/ssh" "$SECURE_DIR/pgp"
  chmod 700 "$SECURE_DIR" "$SECURE_DIR/ssh" "$SECURE_DIR/pgp" || true
}

secure_open_finder_and_pause() {
  section "Secure keys: drop files into ${SECURE_DIR}"
  note "Finder will open now. Put your keys into:"
  echo "  $SECURE_DIR/ssh/"
  echo "  $SECURE_DIR/pgp/"
  echo
  note "SSH expected (any filename is fine, but needs matching .pub):"
  echo "  $SECURE_DIR/ssh/<any-name>"
  echo "  $SECURE_DIR/ssh/<any-name>.pub"
  echo "Example:"
  echo "  $SECURE_DIR/ssh/Dheebz@Github"
  echo "  $SECURE_DIR/ssh/Dheebz@Github.pub"
  echo
  note "PGP expected:"
  echo "  Drop any exported key files into $SECURE_DIR/pgp/"
  echo "  (names can be anything; common: public.asc, secret.asc)"
  echo

  open "$SECURE_DIR" >/dev/null 2>&1 || true

  warn "When you've copied the files in, press Enter to continue (or Ctrl+C to abort)."
  read -r
}

detect_ssh_keypair() {
  # Returns "priv_path|pub_path|key_basename" for the first usable keypair found.
  local dir="$SECURE_DIR/ssh"
  [[ -d "$dir" ]] || return 1

  # If user explicitly set SSH_KEY_NAME, honor it first.
  if [[ -n "${SSH_KEY_NAME}" ]]; then
    local priv="$dir/$SSH_KEY_NAME"
    local pub="$dir/$SSH_KEY_NAME.pub"
    [[ -f "$priv" && -f "$pub" ]] && {
      echo "$priv|$pub|$SSH_KEY_NAME"
      return 0
    }
    return 1
  fi

  # Auto-detect: find private keys (exclude .pub etc.) that have a matching .pub
  local priv
  while IFS= read -r priv; do
    [[ "$priv" == *.pub ]] && continue
    [[ "$priv" == *.pem ]] && continue
    [[ "$priv" == *.asc ]] && continue
    [[ "$priv" == *.gpg ]] && continue
    [[ "$priv" == *.key ]] && continue
    [[ "$priv" == *.pgp ]] && continue
    [[ "$priv" == */known_hosts ]] && continue
    [[ "$priv" == */config ]] && continue

    local pub="${priv}.pub"
    if [[ -f "$pub" ]]; then
      local base
      base="$(basename "$priv")"
      echo "$priv|$pub|$base"
      return 0
    fi
  done < <(find "$dir" -maxdepth 1 -type f -print | sort)

  return 1
}

secure_validate_present() {
  local any=false

  if detect_ssh_keypair >/dev/null 2>&1; then
    any=true
  else
    warn "No SSH keypair found in $SECURE_DIR/ssh/"
    note "Expected: any <name> file PLUS matching <name>.pub"
  fi

  local dir="$SECURE_DIR/pgp"
  if [[ -d "$dir" ]] && find "$dir" -maxdepth 1 -type f \( \
    -iname "*.asc" -o -iname "*.gpg" -o -iname "*.key" -o -iname "*.pgp" \
    \) | grep -q .; then
    any=true
  else
    warn "No PGP key files found in $SECURE_DIR/pgp/"
    note "Expected one or more: *.asc / *.gpg / *.key / *.pgp"
  fi

  $any || return 1
  return 0
}

ensure_ssh_config_github() {
  local key_path="$1"
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"
  local cfg="$HOME/.ssh/config"

  # If config already has a github.com host entry, don't clobber it.
  if [[ -f "$cfg" ]] && awk 'tolower($1)=="host" && $2=="github.com"{found=1} END{exit !found}' "$cfg"; then
    note "~/.ssh/config already has a Host github.com entry; not modifying."
    return 0
  fi

  cat >>"$cfg" <<EOF

Host github.com
  HostName github.com
  User git
  IdentityFile $key_path
  IdentitiesOnly yes
  AddKeysToAgent yes
  UseKeychain yes
EOF
  chmod 600 "$cfg"
  ok "Added Host github.com stanza to ~/.ssh/config"
}

load_ssh_from_secure() {
  local found
  if ! found="$(detect_ssh_keypair)"; then
    note "Skipping SSH load (no keypair present)"
    return 0
  fi

  local src_priv src_pub base
  IFS='|' read -r src_priv src_pub base <<<"$found"

  info "Installing SSH key into ~/.ssh/ (detected: $base)"
  mkdir -p "$HOME/.ssh"
  chmod 700 "$HOME/.ssh"

  install -m 600 "$src_priv" "$HOME/.ssh/$base"
  install -m 644 "$src_pub" "$HOME/.ssh/$base.pub"

  eval "$(ssh-agent -s)" >/dev/null 2>&1 || true
  ssh-add --apple-use-keychain "$HOME/.ssh/$base" >/dev/null 2>&1 ||
    ssh-add "$HOME/.ssh/$base" >/dev/null 2>&1 ||
    warn "ssh-add failed; you may need to run ssh-add manually"

  ensure_ssh_config_github "$HOME/.ssh/$base"

  ok "SSH key installed + loaded into ssh-agent (name: $base)"
}

load_pgp_from_secure() {
  command -v gpg >/dev/null 2>&1 || {
    warn "gpg not installed; skipping PGP import"
    return 0
  }

  local dir="$SECURE_DIR/pgp"
  [[ -d "$dir" ]] || {
    note "Skipping PGP load (no pgp dir)"
    return 0
  }

  # Collect importable files (ASCII armored or binary exports)
  mapfile -t pgp_files < <(find "$dir" -maxdepth 1 -type f \( \
    -iname "*.asc" -o -iname "*.gpg" -o -iname "*.key" -o -iname "*.pgp" \
    \) | sort)

  if [[ "${#pgp_files[@]}" -eq 0 ]]; then
    note "Skipping PGP load (no PGP key files found in $dir)"
    note "Drop exports like: public.asc / secret.asc (names can be anything)"
    return 0
  fi

  info "Importing PGP key material into GnuPG keyring..."
  local f
  for f in "${pgp_files[@]}"; do
    gpg --import "$f" >/dev/null 2>&1 || warn "Failed importing: $f"
  done
  ok "PGP import step complete"

  if [[ "$SET_GIT_SIGNING" == "true" ]]; then
    # Prefer a signing-capable secret key; otherwise fall back to first secret key.
    local kid

    kid="$(gpg --list-secret-keys --with-colons 2>/dev/null |
      awk -F: '
          $1=="sec"{
            # Field 12 = capabilities (e.g. "scESC"); must contain "s"
            if (index($12,"s")>0) { print $5; exit }
          }')"

    if [[ -z "$kid" ]]; then
      kid="$(gpg --list-secret-keys --keyid-format=long 2>/dev/null |
        awk '/^sec/{print $2; exit}' | sed 's|.*/||')"
    fi

    if [[ -n "$kid" ]]; then
      info "Configuring git signing key: $kid"
      git config --global user.signingkey "$kid" || warn "Failed setting user.signingkey"
      git config --global commit.gpgsign true || warn "Failed enabling commit.gpgsign"
      ok "Git signing configured"
    else
      warn "Could not detect a secret key id after import."
      note "Run: gpg --list-secret-keys --keyid-format=long"
    fi
  fi
}

secure_main() {
  secure_init_dirs
  secure_open_finder_and_pause

  if ! secure_validate_present; then
    warn "No usable keys found yet."
    note "Place keys in: $SECURE_DIR then re-run bootstrap (or just this step)."
    return 0
  fi

  run_step "Load SSH keys from .secure" load_ssh_from_secure
  run_step "Import PGP keys from .secure" load_pgp_from_secure
}

# Execute when run directly
if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  secure_main
fi
