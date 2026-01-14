#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

link_dotfiles() {
	local targets=(
		# Files in $HOME
		"file:.zshrc:common/zsh/.zshrc"
		"file:.gitconfig:common/git/.gitconfig"
		"file:.gitignore_global:common/git/.gitignore_global"
		"file:.wezterm.lua:common/wezterm/.wezterm.lua"

		# Directories in $HOME
		"dir:.zsh:common/zsh/.zsh"

		# Config files
		"file:.config/git/allowed_signers:common/git/allowed_signers"
		"file:.config/starship.toml:common/starship/starship.toml"

		# Config directories
		"dir:.config/helix:common/helix"
		"dir:.config/nvim:common/nvim"
	)

	for entry in "${targets[@]}"; do
		IFS=":" read -r type dest src <<<"$entry"

		dest_path="$HOME/$dest"
		src_path="$DOTFILES_DIR/$src"

		mkdir -p "$(dirname "$dest_path")"

		# Backup existing non-symlink
		if [ -e "$dest_path" ] && [ ! -L "$dest_path" ]; then
			backup_path="${dest_path}.bak.$(date +%Y%m%d%H%M%S)"
			mv "$dest_path" "$backup_path"
			info "Backed up $dest_path -> $backup_path"
		fi

		case "$type" in
		file)
			if [ -d "$src_path" ]; then
				error "Expected file but source is a directory: $src_path"
				exit 1
			fi
			ln -sfn "$src_path" "$dest_path"
			info "Linked file $dest_path -> $src_path"
			;;
		dir)
			if [ ! -d "$src_path" ]; then
				error "Expected directory but source is not a directory: $src_path"
				exit 1
			fi
			ln -sfn "$src_path" "$dest_path"
			info "Linked dir  $dest_path -> $src_path"
			;;
		*)
			error "Unknown link type: $type"
			exit 1
			;;
		esac
	done
}

info "Linking dotfiles..."
link_dotfiles
