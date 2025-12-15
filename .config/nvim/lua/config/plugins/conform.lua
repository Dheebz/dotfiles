local flags = require("config.flags")

return {
  "stevearc/conform.nvim",
  enabled = flags.conform,
  event = { "BufWritePre" },
  opts = {
    -- Explicit formatter definitions (so ruff_fix definitely exists)
    formatters = {
      ruff_fix = {
        command = "ruff",
        args = {
          "check",
          "--fix",
          "--exit-zero",
          "--stdin-filename",
          "$FILENAME",
          "-",
        },
        stdin = true,
      },
      ruff_format = {
        command = "ruff",
        args = {
          "format",
          "--stdin-filename",
          "$FILENAME",
          "-",
        },
        stdin = true,
      },
    },

    formatters_by_ft = {
      python = { "ruff_fix", "ruff_format" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
    },

    format_on_save = function(bufnr)
      if vim.b[bufnr].disable_autoformat then
        return
      end
      if vim.bo[bufnr].buftype ~= "" then
        return
      end
      return { timeout_ms = 1500, lsp_fallback = false }
    end,
  },
}

