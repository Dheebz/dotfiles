return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")
      local linters_by_ft = {}

      local function add_linter(ft, linter, executable)
        if vim.fn.executable(executable) == 1 then
          linters_by_ft[ft] = linters_by_ft[ft] or {}
          table.insert(linters_by_ft[ft], linter)
        end
      end

      add_linter("python", "ruff", "ruff")
      add_linter("lua", "luacheck", "luacheck")
      add_linter("rust", "clippy", "cargo")

      lint.linters_by_ft = linters_by_ft

      local lint_group = vim.api.nvim_create_augroup("Linting", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
        group = lint_group,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
