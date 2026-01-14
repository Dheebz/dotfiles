return {
  {
    "nvim-lualine/lualine.nvim",
    enabled = true,
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        globalstatus = true,
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { "filename" },
        lualine_x = {
          "encoding",
          "filetype",
          {
            function()
              local ok, spotify = pcall(require, "spotify")
              if ok then
                return spotify.statusline_compact(15)
              end
              return ""
            end,
            cond = function()
              local ok, spotify = pcall(require, "spotify")
              return ok and spotify.statusline.is_active()
            end,
          },
        },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
  },
}
