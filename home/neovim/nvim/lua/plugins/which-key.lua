return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts.defaults["<leader>q"] = nil
    return opts
  end
}
