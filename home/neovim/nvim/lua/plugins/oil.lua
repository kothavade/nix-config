return {
  "stevearc/oil.nvim",
  config = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Oil",
  keys = {
    {
      "<leader>fm",
      function()
        require("oil").open()
      end,
      desc = "Open File Manager (Oil)",
    },
  },
}
