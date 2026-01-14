return {
  {
    "nvim-treesitter/nvim-treesitter",
    enabled = true,
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ok, configs = pcall(require, "nvim-treesitter.config")
      if not ok then
        return
      end

      configs.setup({
        ensure_installed = { "lua", "vim", "vimdoc", "bash", "json" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
