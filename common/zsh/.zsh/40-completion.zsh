# ~/.zsh/40-completion.zsh
# Completion system and related enhancements

# spotify-cli completions
fpath=(~/.zsh/completions $fpath)
export PATH="$HOME/.local/bin:$PATH"

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# gh completions
if command -v gh >/dev/null 2>&1; then
  eval "$(gh completion -s zsh)"
fi

# fzf integration
if command -v fzf >/dev/null 2>&1; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
fi
