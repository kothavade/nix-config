return {
  {
    "kaarmu/typst.vim",
    ft = "typst",
  },
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "0.1.*",
    build = function()
      require("typst-preview").update()
    end,
  },
}
