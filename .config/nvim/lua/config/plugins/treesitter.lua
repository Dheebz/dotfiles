local flags = require("config.flags")

return {
  "nvim-treesitter/nvim-treesitter",
  enabled = flags.treesitter,

  -- Important: main-branch treesitter says it does NOT support lazy-loading.
  lazy = false,
  build = ":TSUpdate",

  config = function()
    local ts = require("nvim-treesitter")

    -- Minimal setup (main branch API)
    ts.setup({
      -- Put installed parsers/queries in stdpath('data')/site (recommended by upstream)
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- Ensure parsers are installed (no-op if already installed)
    ts.install({ "lua", "python", "bash", "vim", "vimdoc", "query" })

    -- Enable treesitter highlighting for the filetypes you care about
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitterStart", { clear = true }),
      pattern = { "lua", "python", "sh", "bash", "vim", "query" },
      callback = function()
        pcall(vim.treesitter.start)
      end,
    })

    -- Optional: treesitter indentation (plugin provides an indentexpr)
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("UserTreesitterIndent", { clear = true }),
      pattern = { "lua", "python", "sh", "bash", "vim" },
      callback = function()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end,
}

