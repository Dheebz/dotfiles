# ~/.zsh/10-options.zsh
# ZSH options and shell behavior tuning

# History configuration
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# Completion behavior
setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END

# General shell behavior
setopt INTERACTIVE_COMMENTS
setopt NO_FLOW_CONTROL
setopt PROMPT_SUBST
