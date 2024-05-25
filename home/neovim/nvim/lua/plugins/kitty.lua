return {
  "knubie/vim-kitty-navigator",
  event = "VeryLazy",
  build = "cp ./*.py ~/.config/kitty/",
  config = function()
    vim.g.kitty_navigator_no_mappings = 1
    vim.keymap.set('n', '<A-n>', '<cmd>KittyNavigateLeft<cr>', { noremap = true, silent = true })
    vim.keymap.set('n', '<A-o>', '<cmd>KittyNavigateRight<cr>', { noremap = true, silent = true })
    vim.keymap.set('n', '<A-e>', '<cmd>KittyNavigateDown<cr>', { noremap = true, silent = true })
    vim.keymap.set('n', '<A-i>', '<cmd>KittyNavigateUp<cr>', { noremap = true, silent = true })
  end
}
