return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "nvim-telescope/telescope.nvim", -- optional
    "sindrets/diffview.nvim",        -- optional
  },
  opts = {
    disable_hint = true,
    graph_style = "unicode",
    signs = {
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    sections = { recent = { folded = false } },


  },
  keys = {
    {
      "<leader>gg",
      function()
        require("neogit").open({})
      end,
      desc = "Neogit",
    },
    {
      "<leader>gG",
      function()
        require("neogit").open({ cwd = require("lazyvim.util").root.get(), })
      end,
      desc = "Neogit (cwd)",
    },
  },
}
