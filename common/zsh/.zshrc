for file in ~/.zsh/*.zsh; do
	source "$file"
done

# ==========================
# ==== Edit Below this Line
# ==========================

# spotify-cli completions
fpath=(~/.zsh/completions $fpath)
autoload -Uz compinit && compinit
export PATH="$HOME/.local/bin:$PATH"
