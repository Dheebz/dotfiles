# ~/.zsh/40-completion.zsh
# Completion system and related enhancements

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

# gh completions
if command -v gh >/dev/null 2>&1; then
  eval "$(gh completion -s zsh)"
fi

# fzf integration
if command -v fzf >/dev/null 2>&1; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi
