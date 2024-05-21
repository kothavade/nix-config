return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "onsails/lspkind-nvim",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      opts.window = {
        completion = cmp.config.window.bordered({
          col_offset = -3,
          side_padding = 0,
          winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
        }),
        documentation = cmp.config.window.bordered({
          border = "solid",
        }),
      }
      opts.formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            symbol_map = { Copilot = "" },
          })(entry, vim_item)
          local strings = vim.split(kind.kind, "%s", { trimempty = true })
          kind.kind = " " .. (strings[1] or "") .. " "
          kind.menu = "    (" .. (strings[2] or "") .. ")"
          return kind
        end,
        expandable_indicator = true,
      }
    end,
  },
}
