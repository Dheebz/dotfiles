-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Neovim Init                                                          ┃
-- ┃  Modular, profile-based config with plugins                           ┃
-- ┃  File: ~/.config/nvim/init.lua                                        ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

local function safe_require(mod)
  local ok, result = pcall(require, mod)
  if not ok then
    vim.notify(("[init] Failed to load '%s': %s"):format(mod, result), vim.log.levels.ERROR)
    return nil
  end
  return result
end

-- Profile detection
local profile_mod = safe_require("profile")
local profile = profile_mod and profile_mod.detect() or "dheebz"
vim.g.nvim_profile = profile
vim.notify("[nvim-config] Loaded profile: " .. profile, vim.log.levels.INFO)

-- Generic loader for options / keybinds / autocmds
local loader = safe_require("utils.module_loader")
if not loader then
  return
end

-- ──────────────────────────────────────────────────────────────────────────
-- Stage 1: Options (globals + profile)
-- ──────────────────────────────────────────────────────────────────────────
loader.load_namespace("globals.options")
loader.load_namespace("profiles." .. profile .. ".options")

-- ──────────────────────────────────────────────────────────────────────────
-- Stage 2: Plugins (lazy.nvim + specs)
-- ──────────────────────────────────────────────────────────────────────────
local plugins = safe_require("plugins.init")
if plugins and type(plugins.setup) == "function" then
  plugins.setup(profile)
end

-- ──────────────────────────────────────────────────────────────────────────
-- Stage 3: LSP servers (globals + profile-specific)  ← NEW
-- ──────────────────────────────────────────────────────────────────────────
loader.load_namespace("globals.lsp.servers")
loader.load_namespace("profiles." .. profile .. ".lsp.servers")

-- ──────────────────────────────────────────────────────────────────────────
-- Stage 4: Keybinds
-- ──────────────────────────────────────────────────────────────────────────
loader.load_namespace("globals.keybinds")
loader.load_namespace("profiles." .. profile .. ".keybinds")

-- ──────────────────────────────────────────────────────────────────────────
-- Stage 5: Autocmds
-- ──────────────────────────────────────────────────────────────────────────
loader.load_namespace("globals.autocmds")
loader.load_namespace("profiles." .. profile .. ".autocmds")

