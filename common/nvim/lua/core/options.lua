local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.updatetime = 250

local function set_transparent_background()
  local groups = {
    "Normal",
    "NormalNC",
    "NormalFloat",
    "FloatBorder",
    "SignColumn",
    "MsgArea",
    "StatusLine",
    "StatusLineNC",
    "WinSeparator",
    "LineNr",
    "CursorLineNr",
    "EndOfBuffer",
  }

  for _, group in ipairs(groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none" })
  end
end

set_transparent_background()

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = set_transparent_background,
})
