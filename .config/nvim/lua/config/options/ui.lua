-- lua/config/options/ui.lua

vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
-- Yank highlight (flash on yank)
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("UserYankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- Make CursorHold responsive (used for hover diagnostics float)
vim.opt.updatetime = 250

-- Diagnostic signs (icons in the sign column)
local signs = {
  Error = " ",
  Warn  = " ",
  Hint  = " ",
  Info  = " ",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  -- Inline text can get noisy; show only warnings+errors inline
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
})

-- Show diagnostics in a small float when hovering (CursorHold)
vim.api.nvim_create_autocmd("CursorHold", {
  group = vim.api.nvim_create_augroup("UserDiagnosticFloat", { clear = true }),
  callback = function()
    -- avoid popping floats in insert mode
    if vim.fn.mode() ~= "n" then
      return
    end

    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = "cursor",
      border = "rounded",
      source = "if_many",
    })
  end,
})

local border = "rounded"
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

