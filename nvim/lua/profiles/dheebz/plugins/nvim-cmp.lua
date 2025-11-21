-- ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
-- ┃  Completion: nvim-cmp                                                 ┃
-- ┃  Core completion engine for insert mode                               ┃
-- ┃  File: ~/.config/nvim/lua/profiles/dheebz/plugins/nvim-cmp.lua        ┃
-- ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

return {
  "hrsh7th/nvim-cmp",
  enabled = true,
  event = "InsertEnter",
  config = function()
    local cmp = require("cmp")
    local luasnip_ok, luasnip = pcall(require, "luasnip")

    cmp.setup({
      snippet = {
        expand = function(args)
          if luasnip_ok then
            luasnip.lsp_expand(args.body)
          end
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"]      = cmp.mapping.confirm({ select = true }),
        ["<C-j>"]     = cmp.mapping.select_next_item(),
        ["<C-k>"]     = cmp.mapping.select_prev_item(),
        ["<C-e>"]     = cmp.mapping.abort(),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
      }, {
        { name = "path" },
        { name = "buffer" },
        { name = "spell" },
        { name = "nvim_lua" },
      }),
    })

    -- Optional: cmdline completion (tied to cmp-cmdline)
    cmp.setup.cmdline("/", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}

-- End of File: ~/.config/nvim/lua/profiles/dheebz/plugins/nvim-cmp.lua
