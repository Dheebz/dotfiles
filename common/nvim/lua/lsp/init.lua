local M = {}

function M.setup()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  end

  local function make_on_attach(user_on_attach)
    return function(client, bufnr)
      if user_on_attach then
        user_on_attach(client, bufnr)
      end

      local navic_ok, navic = pcall(require, "nvim-navic")
      if navic_ok and client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
      end
    end
  end

  local servers = require("lsp.servers")
  local enabled_servers = {}

  for name, cfg in pairs(servers) do
    if cfg.enabled then
      table.insert(enabled_servers, name)
    end
  end

  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = enabled_servers,
  })

  for name, cfg in pairs(servers) do
    if cfg.enabled then
      local opts = cfg.opts or {}
      opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities or {})
      opts.on_attach = make_on_attach(opts.on_attach)
      if cfg.settings then
        opts.settings = cfg.settings
      end
      if cfg.filetypes then
        opts.filetypes = cfg.filetypes
      end
      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end
  end
end

return M
