return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "typescript", "tsx" })
      end
    end,
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    event = { "BufReadPre", "BufNewFile" },
    ft = { "typescript", "typescriptreact" },
    config = true
  },
  -- TODO: don't auto-load this with nvim-cmp?
  -- {
  --   "roobert/tailwindcss-colorizer-cmp.nvim",
  --   ft = { "typescript", "typescriptreact", "astro", "vue" },
  -- }
}
