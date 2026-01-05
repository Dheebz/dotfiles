local wezterm = require 'wezterm'

return {
  -- Appearance
  color_scheme = "Tokyo Night",
  font_size = 13.0,
  window_background_opacity = 0.90, -- 90% opacity
  text_background_opacity = 0.90,   -- For transparency in text cells
  enable_tab_bar = false,           -- Hide tab bar
  window_padding = {
    left = 8,
    right = 8,
    top = 8,
    bottom = 8,
  },

  -- Startup shell
  default_prog = { "/bin/zsh", "-l" },

  -- Key bindings
  keys = {
    -- Corrected split directions
    { key = "V",          mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { key = "S",          mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },

    -- Move between panes (Vim-style)
    { key = "h",          mods = "CTRL",       action = wezterm.action.ActivatePaneDirection "Left" },
    { key = "j",          mods = "CTRL",       action = wezterm.action.ActivatePaneDirection "Down" },
    { key = "k",          mods = "CTRL",       action = wezterm.action.ActivatePaneDirection "Up" },
    { key = "l",          mods = "CTRL",       action = wezterm.action.ActivatePaneDirection "Right" },

    -- Move between panes (Arrow keys)
    { key = "LeftArrow",  mods = "CTRL",       action = wezterm.action.ActivatePaneDirection "Left" },
    { key = "DownArrow",  mods = "CTRL",       action = wezterm.action.ActivatePaneDirection "Down" },
    { key = "UpArrow",    mods = "CTRL",       action = wezterm.action.ActivatePaneDirection "Up" },
    { key = "RightArrow", mods = "CTRL",       action = wezterm.action.ActivatePaneDirection "Right" },
  },
}
