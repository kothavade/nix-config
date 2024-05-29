local disabled = {
  -- Use Nix instead of mason
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "jay-babu/mason-nvim-dap.nvim",

  "catppuccin",
  "akinsho/bufferline.nvim",
  "folke/noice.nvim",
  "folke/noice.nvim",
  "folke/tokyonight.nvim",
  "nvim-neo-tree/neo-tree.nvim",
  "kawre/leetcode.nvim",
  "rcarriga/nvim-notify",
  "linux-cultist/venv-selector.nvim",
  "persistence.nvim",
  "echasnovski/mini.indentscope",
  "echasnovski/mini.pairs",
}

local ret = {}
for _, v in ipairs(disabled) do
  table.insert(ret, { v, enabled = false })
end
return ret
