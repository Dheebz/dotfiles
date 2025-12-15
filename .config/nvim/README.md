# Neovim Config

Lean, lazy‑first Neovim tuned for quick startup, transparent visuals, and batteries‑included editing. Everything is split into small modules (`lua/config/**`) and feature‑gated through `lua/config/flags.lua` so you can toggle pieces without surgery.

## Philosophy
- Fast by default: lazy‑loads almost everything and keeps only the essentials always on.
- Toggle‑driven: set booleans in `lua/config/flags.lua` to enable/disable whole feature areas.
- Clarity over clutter: transparent TokyoNight theme, rounded borders, minimal noise from diagnostics.
- Task ready: LSP/formatting (ruff, shfmt), Telescope search, Git signs, and a friendly terminal always within reach.
- Small, readable modules: options, keymaps, and plugins live in focused files for easy diffing.

## Quickstart
- Requirements: Neovim 0.11+ (uses `vim.lsp.config/enable`), Git, and `rg` for Telescope. For formatting: `ruff` and `shfmt` on your PATH.
- Install: place this repo at `~/.config/nvim` (or symlink it there).
- First run: open `nvim`; lazy.nvim bootstraps itself and installs plugins. Mason can be opened later with `:Mason` if you want a UI for external tools.

## Daily Use
- File tree: `<leader>e` toggle, `<leader>E` focus (Neo-tree).
- Search: `<leader>ff` files (git aware, falls back to hidden files), `<leader>fg` live grep, `<leader>fw` grep word under cursor.
- LSP: `gd` definition, `gr` references, `K` hover, `<leader>rn` rename, `<leader>ca` code action; diagnostics: `<leader>vd`, `[d`/`]d`.
- Formatting: auto‑format on save via conform.nvim; per buffer toggle with `:FormatDisable` / `:FormatEnable`.
- Git: `<leader>gp` preview hunk, `<leader>gr` reset hunk, `<leader>gb` blame line.
- Terminal: `<leader>tt` toggles ToggleTerm; `<Esc>` exits terminal mode.
- Navigation helpers: `<leader>j` Flash jump, `<leader>J` Flash Treesitter.
- UI/diagnostics: `<leader>xx` Trouble list; yank highlight and rounded floating borders are built in.

## Plugin Stack (high level)
- LSP & tooling: `mason.nvim`, `mason-lspconfig.nvim`, `nvim-lspconfig` with Lua/Bash/Ruff/Ty servers, `lsp_signature`.
- Completion/snippets: `nvim-cmp` + buffer/path/LSP sources and `LuaSnip`.
- Editing niceties: `mini.surround`, `Comment.nvim`, `nvim-autopairs`, `vim-repeat`.
- Search/navigation: `telescope.nvim` (hidden files + git aware), `nvim-treesitter`, `flash.nvim`.
- UI: transparent `tokyonight.nvim`, `lualine.nvim`, `noice.nvim`, `which-key.nvim`, `twilight.nvim`.
- Git/diagnostics: `gitsigns.nvim`, `todo-comments.nvim`, `trouble.nvim`.
- Terminal/formatting: `toggleterm.nvim`, `conform.nvim`.

## Extending and Customizing
- Toggle features: flip booleans in `lua/config/flags.lua` to disable or enable plugin families.
- Add a plugin: drop a spec file in `lua/config/plugins/your-plugin.lua` (see existing files for shape). lazy.nvim auto-imports everything in that folder.
- Adjust options/keymaps: edit the relevant module in `lua/config/options/**` or `lua/config/keymaps/**` to keep concerns separated.
- LSP/tooling: add servers in `lua/config/plugins/nvim-lspconfig.lua` and wire formatters in `lua/config/plugins/conform.lua`; Mason is optional if you prefer manual installs.

Keep changes small and localized—most modules are single-purpose to make reviewing diffs and experimenting low-risk.
