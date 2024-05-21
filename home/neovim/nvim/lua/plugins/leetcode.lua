local leet_arg = "lc"

return {
  "kawre/leetcode.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
    {
      "3rd/image.nvim",
      config = true
    },
  },
  opts = {
    arg = leet_arg,
    storage = {
      home = "/Users/ved/code/leetcode",
    },
    image_support = false,
    lang = "python3",
  },
  lazy = leet_arg ~= vim.fn.argv()[1],
  keys = {
    {
      "<leader>Lm",
      function()
        -- Leet menu
        vim.cmd("Leet menu")
      end,
      desc = "Leet menu",
    },
    {
      "<leader>Lr",
      function()
        vim.cmd("Leet run")
      end,
      desc = "Leet run",
    },
    {
      "<leader>Ls",
      function()
        vim.cmd("Leet submit")
      end,
      desc = "Leet submit",
    },
    {
      "<leader>Ll",
      function()
        vim.cmd("Leet list")
      end,
      desc = "Leet list",
    },
  },
}
