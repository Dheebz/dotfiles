return {
  lua_ls = {
    enabled = true,
    settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim" } },
        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
        telemetry = { enable = false },
      },
    },
  },
  bashls = { enabled = true },
  jsonls = { enabled = true },
}
