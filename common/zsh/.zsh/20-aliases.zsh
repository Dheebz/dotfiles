# ~/.zsh/20-aliases.zsh
# Aliases for safer and faster CLI usage

# Safer file ops
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# ls replacements
alias ls="eza"
alias ll="eza -alF"
alias la="eza -a"
alias lt="eza --tree"

# Git
alias g="git"
alias gst="git status"
alias gl="git pull"
alias gp="git push"
alias gaa="git add -A"
alias gcm="git commit -m"

# Editors
alias h="hx"

# Others
alias c="clear"
alias path='echo -e ${PATH//:/\n}'
