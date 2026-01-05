# ~/.zsh/99-sourced.zsh
# Optional extras sourced last

# Load Bitwarden env secrets, if file exists
SECURE_ENV="$HOME/.secure/.secure-env"
if [[ -f "$SECURE_ENV" ]]; then
  source "$SECURE_ENV"
fi

# Custom final hooks (e.g. local overrides)
[[ -f "$HOME/.zsh_local" ]] && source "$HOME/.zsh_local"
