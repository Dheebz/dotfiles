# ~/.zshrc - managed by dotfiles (shell/.zshrc)

########################################
# Homebrew
########################################
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

# Ensure the directory exists (install.sh also does this; harmless here)
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
setopt sharehistory           # already set, but explicit
# you can add more setopt lines here if you want

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

# Core ls aliases (only used if eza not overriding)
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Editor
alias vim='nvim'

# Safer file operations
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Git aliases
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate'
alias gp='git push'
alias gpl='git pull --rebase'

########################################
# Project helpers
########################################

# Jump to/create a project in ~/Workspace
cproj() {
  if [[ -z "$1" ]]; then
    echo "Usage: cproj <name>" >&2
    return 1
  fi
  local dir="$WORKSPACE/$1"
  mkdir -p "$dir"
  cd "$dir" || return
}

# mkdir + cd
mkcd() {
  if [[ -z "$1" ]]; then
    echo "Usage: mkcd <dir>" >&2
    return 1
  fi
  mkdir -p "$1"
  cd "$1" || return
}

########################################
# Auto-activate Python virtualenvs in ~/Workspace
########################################
# - Only triggers when PWD is under $WORKSPACE
# - Looks for: .venv, .env, venv, env
# - Only deactivates envs it auto-activated (tracked in __AUTO_VENV_CURRENT)

__AUTO_VENV_CURRENT=""

_auto_venv_chpwd() {
  # Only care about directories inside $WORKSPACE
  if [[ "$PWD" != "$WORKSPACE"* ]]; then
    # If we previously auto-activated something, deactivate when leaving Workspace
    if [[ -n "$__AUTO_VENV_CURRENT" ]] && typeset -f deactivate >/dev/null; then
      #echo "deactivating virtualenv ($__AUTO_VENV_CURRENT)"
      deactivate
      __AUTO_VENV_CURRENT=""
    fi
    return
  fi

  local env_path=""
  local candidate

  # Check common virtualenv directory names in priority order
  for candidate in ".venv" ".env" "venv" "env"; do
    if [[ -d "$PWD/$candidate" && -f "$PWD/$candidate/bin/activate" ]]; then
      env_path="$PWD/$candidate"
      break
    fi
  done

  # No env in this directory
  if [[ -z "$env_path" ]]; then
    # If we auto-activated something previously, and there is no env here, deactivate
    if [[ -n "$__AUTO_VENV_CURRENT" ]] && typeset -f deactivate >/dev/null; then
      #echo "deactivating virtualenv ($__AUTO_VENV_CURRENT)"
      deactivate
      __AUTO_VENV_CURRENT=""
    fi
    return
  fi

  # Already using this env
  if [[ "$VIRTUAL_ENV" == "$env_path" ]]; then
    __AUTO_VENV_CURRENT="$env_path"
    return
  fi

  # Switching to a different env we manage
  if [[ -n "$__AUTO_VENV_CURRENT" ]] && typeset -f deactivate >/dev/null; then
    #echo "deactivating virtualenv ($__AUTO_VENV_CURRENT)"
    deactivate
  fi

  echo "activating virtualenv: $env_path"
  source "$env_path/bin/activate"
  __AUTO_VENV_CURRENT="$env_path"
}

autoload -Uz add-zsh-hook
add-zsh-hook chpwd _auto_venv_chpwd

# Run once on shell startup too (for when you open directly in a project dir)
_auto_venv_chpwd

export GPG_TTY=$(tty)
