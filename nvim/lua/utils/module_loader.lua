-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Module Loader                                                        ┃
-- ┃  Loads feature modules with { enabled = bool, setup = function() }    ┃
-- ┃  File: ~/.config/nvim/lua/utils/module_loader.lua                     ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}

function M.load_namespace(namespace)
  local root = vim.fn.stdpath("config") .. "/lua/"
  local path = root .. namespace:gsub("%.", "/")

  local ok, files = pcall(vim.fn.readdir, path)
  if not ok then
    -- Silently ignore missing dirs
    return
  end

  for _, file in ipairs(files) do
    if file:match("%.lua$") then
      local module_name = namespace .. "." .. file:gsub("%.lua$", "")

      local ok_mod, mod = pcall(require, module_name)
      if not ok_mod then
        vim.notify(
          ("[loader] Failed to load '%s': %s"):format(module_name, mod),
          vim.log.levels.ERROR
        )
      else
        if type(mod) == "table" and mod.enabled ~= false and type(mod.setup) == "function" then
          mod.setup()
        end
        -- If it doesn't have setup()/is disabled, we just quietly skip it
      end
    end
  end
end

return M

-- End of File: ~/.config/nvim/lua/utils/module_loader.lua
