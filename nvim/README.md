
---

## 4. `nvim/README.md`

Create `dotfiles-main/nvim/README.md`:

```markdown
# Neovim config

This is my Neovim configuration, designed for daily development work.

- Target version: **Neovim 0.9+** (0.10 recommended)
- Location: `~/.config/nvim`
- Entry point: [`init.lua`](./init.lua)

The config is **modular** and **profile-based**:

- `init.lua` loads a `profile` module
- `lua/globals/…` contains options, keymaps, autocmds and LSP setup
- Plugins are managed via `lazy.nvim` (see `lazy-lock.json`)

## Features (high level)

- Sensible defaults (line numbers, splits, search, indentation, etc.)
- LSP support (Lua and other languages)
- Treesitter-based syntax highlighting
- Useful keybindings with a Vim-y feel
- Quality-of-life tweaks via modules in `lua/globals/options/`

## Requirements

Installed via `script.sh`:

- `neovim`
- `ripgrep` (for live grep / telescope-style search)
- `fd` (for fast file searching)
- `git`

Language-specific tooling (LSP servers, formatters) should be installed per language.

## Installation

If you ran `./script.sh` or `./install.sh`, you’re done – it symlinks:

```text
~/.config/nvim -> ~/.dotfiles/nvim

