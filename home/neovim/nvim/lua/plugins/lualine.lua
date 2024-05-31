return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      section_separators = '',
      component_separators = ''
    },
    extensions = { "lazy" },
    sections = {
      -- Remove clock from lualine
      lualine_z = {},
    },
  }
}
