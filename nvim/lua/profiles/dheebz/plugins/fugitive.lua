-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Git: vim-fugitive                                                    ┃
-- ┃  Git porcelain inside Neovim                                          ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/plugins/fugitive.lua        ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "tpope/vim-fugitive",
  enabled = true,
  cmd = { "Git", "G", "Gdiffsplit", "Gblame" },
}

-- End of File: ~/.config/nvim/lua/profiles/dheebz/plugins/fugitive.lua
