#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

link_dotfiles() {
	local targets=(
		".zshrc:common/zsh/.zshrc"
		".zsh:common/zsh/.zsh"
		".gitconfig:common/git/.gitconfig"
		".gitignore_global:common/git/.gitignore_global"
		".config/git/allowed_signers:common/git/allowed_signers"
		".wezterm.lua:common/wezterm/.wezterm.lua"
		".config/starship.toml:common/starship/starship.toml"
		".config/helix/config.toml:common/helix/config.toml"
		".config/helix/languages.toml:common/helix/languages.toml"
		".config/helix/themes/my_tokyonight.toml:common/helix/themes/my_tokyonight.toml"
	)

	for entry in "${targets[@]}"; do
		IFS=":" read -r dest src <<<"$entry"
		dest_path="$HOME/$dest"
		src_path="$DOTFILES_DIR/$src"

		mkdir -p "$(dirname "$dest_path")"
		if [ -d "$dest_path" ] && [ ! -L "$dest_path" ]; then
			backup_path="${dest_path}.bak.$(date +%Y%m%d%H%M%S)"
			mv "$dest_path" "$backup_path"
			info "Backed up existing directory $dest_path -> $backup_path"
		fi
		ln -sfn "$src_path" "$dest_path"
		info "Linked $dest_path -> $src_path"
	done
}

info "Linking dotfiles..."
link_dotfiles
