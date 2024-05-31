-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.lazyvim_python_lsp = "basedpyright"
-- https://x.com/mitchellh/status/1787180650782703989
vim.opt.termsync = false
-- Opaque completion
vim.opt.pumblend = 0
-- Hyprlang
vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
