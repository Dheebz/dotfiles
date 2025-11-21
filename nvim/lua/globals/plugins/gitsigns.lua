-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  GitSigns                                                             ┃
-- ┃  File: ~/.config/nvim/lua/globals/plugins/gitsigns.lua                ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
return {
  "lewis6991/gitsigns.nvim",
  enabled = true,                        -- Your toggle flag
  event = { "BufReadPre", "BufNewFile" }, -- Only load when you're actually editing a file
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "✨" },
        change = { text = "🛠️" },
        delete = { text = "🔥" },
        topdelete = { text = "💀" },
        changedelete = { text = "🔧" },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, lhs, rhs, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, lhs, rhs, opts)
        end
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(gs.next_hunk)
          return "<Ignore>"
        end, { expr = true })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(gs.prev_hunk)
          return "<Ignore>"
        end, { expr = true })

        map("n", "<leader>hs", gs.stage_hunk)
        map("n", "<leader>hr", gs.reset_hunk)
        map("n", "<leader>hb", gs.blame_line)
      end,
    })
  end, -- closes the config = function()
}



-- End of File: ~/.config/nvim/lua/globals/plugins/gitsigns.lua
