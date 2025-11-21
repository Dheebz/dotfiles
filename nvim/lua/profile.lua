-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Profile Detection                                                    ┃
-- ┃  File: ~/.config/nvim/lua/profile.lua                                 ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local M = {}

function M.detect()
  local env_profile = vim.env.NVIM_PROFILE
  if env_profile and env_profile ~= "" then
    return env_profile
  end
  return "dheebz"
end

return M

-- End of File: ~/.config/nvim/lua/profile.lua
