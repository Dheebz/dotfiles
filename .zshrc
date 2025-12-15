# ---------------------------------------------------------------------------
# Dheebz dotfiles: interactive zsh configuration
#
# Purpose:
# - Provide a minimal, documented, portable `~/.zshrc` that works after a fresh
#   macOS install (Homebrew, starship, fzf, node, go, rust, bun, etc.).
# - Wire up useful defaults, completions, and safe aliases.
# - Auto-activate Python venvs when entering projects under `$WORKSPACE`.
# - Record every interactive command run to a timestamped log for auditing
#   (stored in `$XDG_STATE_HOME` or `$HOME/.local/state/logs`).
#
# Notes / security:
# - The command log includes the command text and working directory and is
#   appended for every interactive command — treat it as sensitive.
# - The bootstrap process that installs tools may prompt for sudo or GUI
#   interactions; inspect scripts before running using the safer download
#   workflow described in README.md.
# ---------------------------------------------------------------------------

# -------------------------
# Command logging (interactive shells)
# -------------------------
# Create a log file and append one line per executed command with ISO timestamp,
# current working directory, and the exact command string. This helps with
# auditing or replaying what was run during a bootstrap.
# NOTE: this records commands (not output) and may include secrets if typed.
if [[ -o interactive ]]; then
  # Toggle for command logging. Default is false. Set to 'true', '1', 'yes', or
  # 'on' to enable (can be set externally e.g. `export ENABLE_CMD_LOGGING=true`).
  ENABLE_CMD_LOGGING="${ENABLE_CMD_LOGGING:-false}"
  _dotfiles__logging_enabled() {
    case "${ENABLE_CMD_LOGGING}" in
      [Tt][Rr][Uu][Ee]|1|yes|on) return 0 ;;
      *) return 1 ;;
    esac
  }

  if [[ -o interactive ]] && _dotfiles__logging_enabled; then
  XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
  LOG_DIR="$XDG_STATE_HOME/logs"
  mkdir -p "$LOG_DIR" 2>/dev/null || true
  LOG_FILE="$LOG_DIR/shell_commands.log"

  __dotfiles__log_preexec() {
    # $1 is the command about to run
    local cmd="$1"
    local when
    when="$(date '+%Y-%m-%dT%H:%M:%S%z')"
    # format: timestamp<TAB>cwd<TAB>command
    printf "%s\t%s\t%s\n" "$when" "$PWD" "$cmd" >> "$LOG_FILE"
  }

  # Register the logger with zsh's preexec hook(s) without clobbering
  if typeset -p preexec_functions >/dev/null 2>&1; then
    preexec_functions+=(__dotfiles__log_preexec)
  else
    preexec() { __dotfiles__log_preexec "$@"; }
  fi
  fi
fi

# ---------------------------------------------------------------------------
# Homebrew
# ---------------------------------------------------------------------------
if command -v brew >/dev/null 2>&1; then
  # Works for /opt/homebrew, /usr/local, etc.
  eval "$(brew shellenv)"
fi
########################################
# PATH
########################################
export PATH="$HOME/.local/bin:$PATH"
########################################
# Workspace
########################################
export WORKSPACE="$HOME/Workspace"
alias cwork='cd "$WORKSPACE"'
# Ensure the directory exists
[ -d "$WORKSPACE" ] || mkdir -p "$WORKSPACE"
########################################
# History settings
########################################
HISTFILE="$HOME/.zsh_history"
HISTSIZE=20000
SAVEHIST=20000
setopt HIST_IGNORE_DUPS        # don't record immediately repeated commands
setopt HIST_IGNORE_ALL_DUPS    # remove older duplicate when new one is added
setopt HIST_REDUCE_BLANKS      # remove superfluous blanks
setopt SHARE_HISTORY           # share history across all sessions
# Timestamp format for 'history'
export HIST_STAMPS="yyyy-mm-dd"
########################################
# Completion
########################################
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
# case-insensitive, partial matches, etc.
zstyle ':completion:*' matcher-list \
  'm:{a-z}={A-Z}' \
  'r:|[._-]=* r:|=*'
########################################
# Starship prompt
########################################
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi
########################################
# General shell options
########################################
export EDITOR="nvim"
setopt autocd                 # 'cd' implicitly when you type a dir
setopt histignorealldups      # (paired with HIST_* above)
########################################
# fzf integration
########################################
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"
########################################
# NVM (Node Version Manager)
########################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
########################################
# Optional fancy tools (if installed)
########################################
# eza as ls replacement
if command -v eza >/dev/null 2>&1; then
  alias ls='eza'
  alias ll='eza -alF'
  alias la='eza -a'
  alias lt='eza --tree'
fi

# bat as cat replacement
if command -v bat >/dev/null 2>&1; then
  alias cat='bat'
fi

# zoxide for smarter cd
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias c='z'  # quick jump
fi
########################################
# Aliases
########################################

alias ll='ls -alF'
alias la='ls -a'
alias l='ls -CF'

BREW_PREFIX="$(brew --prefix 2>/dev/null || echo /opt/homebrew)"

# PATH additions: brew, bun, cargo, go, node, user's bin
export GOPATH="${GOPATH:-$HOME/go}"
export GOBIN="$GOPATH/bin"
mkdir -p "$GOBIN" 2>/dev/null || true

export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$HOME/.bun/bin:$HOME/.cargo/bin:$GOBIN:$PATH"

# If npm has a global prefix, add its bin to PATH
if command -v npm >/dev/null 2>&1; then
  npm_prefix="$(npm config get prefix 2>/dev/null || true)"
  if [ -n "$npm_prefix" ]; then
    export PATH="$npm_prefix/bin:$PATH"
  fi
fi
# Editor
alias vim='nvim'

# Safer file operations
alias rm='rm -i'
 
# Source cargo env if present (rustup)
if [ -f "$HOME/.cargo/env" ]; then
  # shellcheck disable=SC1090
  source "$HOME/.cargo/env"
fi
alias cp='cp -i'
alias mv='mv -i'

# Git aliases
if [ -d "$BREW_PREFIX/opt/fzf" ]; then
  [ -f "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ] && source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
  [ -f "$BREW_PREFIX/opt/fzf/shell/completion.zsh" ] && source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"
fi

# GitHub CLI completion
if command -v gh >/dev/null 2>&1; then
  if gh completion -s zsh >/dev/null 2>&1 2>/dev/null; then
    eval "$(gh completion -s zsh)" 2>/dev/null || true
  fi
fi


alias gs='git status'
alias ga='git add'
alias gca='git commit --amend'
alias gb='git branch'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate'
alias gp='git push'
alias gpl='git pull --rebase'
alias grs='git restore'


########################################
# Auto-activate Python virtualenvs in ~/Workspace
########################################
# Behavior:
# - Only triggers when PWD is under $WORKSPACE
# - Searches upward from the current directory to the project root (stopping
#   at $WORKSPACE) for any of: .venv, .env, venv, env
# - Keeps the venv active while you move inside the project (e.g. project/src)
# - Only deactivates when you leave the project tree (or the Workspace)
__AUTO_VENV_CURRENT=""
_auto_venv_chpwd() {
  # Only care about directories inside $WORKSPACE
  if [[ "$PWD" != "$WORKSPACE"* ]]; then
    if [[ -n "$__AUTO_VENV_CURRENT" ]] && typeset -f deactivate >/dev/null; then
      deactivate
      __AUTO_VENV_CURRENT=""
    fi
    return
  fi

  local lookup="$PWD"
  local env_path=""
  local candidate

  # Walk up from $PWD to $WORKSPACE looking for a venv directory in an ancestor
  while true; do
    for candidate in ".venv" ".env" "venv" "env"; do
      if [[ -d "$lookup/$candidate" && -f "$lookup/$candidate/bin/activate" ]]; then
        env_path="$lookup/$candidate"
        break 2
      fi
    done
    # Stop if we've reached the workspace root or filesystem root
    if [[ "$lookup" == "$WORKSPACE" || "$lookup" == "/" ]]; then
      break
    fi
    lookup=$(dirname -- "$lookup")
  done

  # If no env found in this project tree, deactivate any previously auto-activated env
  if [[ -z "$env_path" ]]; then
    if [[ -n "$__AUTO_VENV_CURRENT" ]] && typeset -f deactivate >/dev/null; then
      deactivate
      __AUTO_VENV_CURRENT=""
    fi
    return
  fi

  # Already active and matches the desired env
  if [[ "$VIRTUAL_ENV" == "$env_path" ]]; then
    __AUTO_VENV_CURRENT="$env_path"
    return
  fi

  # Switch from a different auto-activated env if present
  if [[ -n "$__AUTO_VENV_CURRENT" ]] && typeset -f deactivate >/dev/null; then
    deactivate
  fi

  echo "activating virtualenv: $env_path"
  # shellcheck disable=SC1090
  source "$env_path/bin/activate"
  __AUTO_VENV_CURRENT="$env_path"
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _auto_venv_chpwd

# Run once on shell startup too (for when you open directly in a project dir)
_auto_venv_chpwd

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

fpath+=~/.zfunc; autoload -Uz compinit; compinit


if [[ -f "$HOME/.secure/aoc.env" ]]; then
  export SESSION_TOKEN="$(< "$HOME/.secure/aoc.env")"
fi
