return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      filetypes = {
        markdown = true,
        help = true,
        python = function()
          -- check if in /Users/ved/code/leetcode
          if string.match(vim.api.nvim_buf_get_name(0), "/Users/ved/code/leetcode") then
            return false
          end
          return true
        end,
      },
    },
    keys = {
      {
        "<leader>at",
        function()
          vim.cmd("Copilot toggle")
        end,
        desc = "Toggle AI",
      }
    }

  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        ["<leader>a"] = { name = "+ai" }
      }
    },
  }
}
