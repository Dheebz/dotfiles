-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Plugin Bootstrap (lazy.nvim)                                        ┃
-- ┃  Wires lazy.nvim with global + profile plugin specs                   ┃
-- ┃  File: ~/.config/nvim/lua/plugins/init.lua                            ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}

--- Setup plugins for the given profile.
--- @param profile string
function M.setup(profile)
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable",
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  local ok, lazy = pcall(require, "lazy")
  if not ok then
    vim.notify("[plugins] Failed to load lazy.nvim", vim.log.levels.ERROR)
    return
  end

  lazy.setup({
    spec = {
      { import = "globals.plugins" },
      { import = "profiles." .. profile .. ".plugins" },
    },
    defaults = {
      lazy = true,
      version = false,
    },
    install = {
      colorscheme = { "tokyonight-night" },
    },
    checker = {
      enabled = false,
      notify = false,
    },
  })
end

return M

-- End of File: ~/.config/nvim/lua/plugins/init.lua
