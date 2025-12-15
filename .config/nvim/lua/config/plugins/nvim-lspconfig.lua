local flags = require("config.flags")

return {
  "neovim/nvim-lspconfig",
  enabled = flags.nvim_lspconfig,
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Buffer-local LSP keymaps (0.11-friendly)
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspKeymaps", { clear = true }),
      callback = function(ev)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
        end

        map("n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
        map("n", "gr", vim.lsp.buf.references, "LSP: References")
        map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")

        map("n", "<leader>vd", vim.diagnostic.open_float, "Diagnostics: Line")
        map("n", "[d", vim.diagnostic.goto_prev, "Diagnostics: Prev") -- TODO: fix
        map("n", "]d", vim.diagnostic.goto_next, "Diagnostics: Next") -- TODO: fix
      end,
    })

    -- Capabilities for completion (nvim-cmp)
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if ok_cmp then
      capabilities = cmp_lsp.default_capabilities(capabilities)
    end

    -- LUA (lua_ls) – extend the default config shipped by nvim-lspconfig
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enabled = false },
        },
      },
    })

    -- BASH (bashls)
    vim.lsp.config("bashls", {
      capabilities = capabilities,
    })

    -- RUFF
    -- Use Ruff’s native language server ("ruff server") rather than ruff-lsp.
    -- ruff-lsp has been deprecated in favor of the native server. :contentReference[oaicite:4]{index=4}
    vim.lsp.config("ruff", {
      capabilities = capabilities,
      cmd = { "ruff", "server" },
      filetypes = { "python" },
      root_markers = { "pyproject.toml", "ruff.toml", ".git" },
    })

    -- TY
    vim.lsp.config("ty", {
      capabilities = capabilities,
      cmd = { "ty", "server" },
      filetypes = { "python" },
      root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" },
      settings = {
        ty = {
          -- Keep defaults for now.
          -- You can add options here later (e.g., disableLanguageServices if you ever pair with pyright).
        },
      },
    })

    -- Finally: enable servers (this is the 0.11+ way)
    vim.lsp.enable({ "lua_ls", "bashls", "ruff", "ty" })
  end,
}
