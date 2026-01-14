return {
  {
    "SmiteshP/nvim-navic",
    event = "LspAttach",
    config = function()
      require("nvim-navic").setup({
        highlight = true,
        lsp = {
          auto_attach = false,
        },
      })
    end,
  },
}
