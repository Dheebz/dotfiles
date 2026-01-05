# ~/.zsh/50-tools.zsh
# Tool-specific shell initializations

# bat as man pager
if command -v bat >/dev/null 2>&1; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"

# fnm or volta (if ever used)
# eval "$(fnm env --use-on-cd)"

# cargo (already in PATH from 00-env)
# bun also handled in 00-env


# direnv integration
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

