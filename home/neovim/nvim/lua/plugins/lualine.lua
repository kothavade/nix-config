return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    local gruv = require("lualine.themes.gruvbox")
    gruv.normal.c.bg = "#282828"
    return {
      options = {
        theme = gruv,
        section_separators = '',
        component_separators = ''
      },
      extensions = { "lazy" },
      sections = {
        -- Remove clock from lualine
        lualine_z = {},
      },
    }
  end,
}
