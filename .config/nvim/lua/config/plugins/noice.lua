local flags = require("config.flags")

return {
  "folke/noice.nvim",
  enabled = flags.noice,
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- Optional but recommended: pretty notifications
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      -- Keep LSP hover/signature nice
      hover = { enabled = true },
      signature = { enabled = true },

      -- Reduce noisy markdown rendering issues
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },

    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = true,
    },
  },
}

