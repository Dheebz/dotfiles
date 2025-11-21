-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Auto-Reload: Reload Files Changed Outside of Neovim                    ┃
-- ┃  File: ~/.config/nvim/lua/<profile>/autocmds/auto-reload.lua            ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  callback = function()
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = 0 })
    local filetype = vim.bo.filetype
    -- Skip checktime if inside command-line, lazy, telescope, or other special buffers
    if buftype ~= "" or filetype == "TelescopePrompt" or filetype == "lazy" or filetype == "qf" then
      return
    end
    vim.cmd("checktime")
  end,
  desc = "Auto-reload files if changed externally",
})

-- End of File: ~/.config/nvim/lua/<profile>/autocmds/auto-reload.lua
