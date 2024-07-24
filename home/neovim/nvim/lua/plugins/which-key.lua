return {
  "folke/which-key.nvim",
  opts = function(_, opts)
    opts.spec["<leader>q"] = nil
    return opts
  end
}
