-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Trouble.nvim                                                         ┃
-- ┃  Pretty diagnostics/refs/loclist UI                                   ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/plugins/trouble-nvim.lua    ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "folke/trouble.nvim",
  enabled = true,
  cmd = { "Trouble", "TroubleToggle" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    use_diagnostic_signs = true,
  },
  config = function(_, opts)
    require("trouble").setup(opts)

    local map = vim.keymap.set
    local function o(desc)
      return { noremap = true, silent = true, desc = "[trouble] " .. desc }
    end

    map("n", "<leader>xx", "<cmd>TroubleToggle document_diagnostics<CR>", o("Document diagnostics"))
    map("n", "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<CR>", o("Workspace diagnostics"))
    map("n", "<leader>xq", "<cmd>TroubleToggle quickfix<CR>",              o("Quickfix"))
    map("n", "<leader>xl", "<cmd>TroubleToggle loclist<CR>",               o("Loclist"))
  end,
}

-- End of File: ~/.config/nvim/lua/profiles/dheebz/plugins/trouble-nvim.lua
