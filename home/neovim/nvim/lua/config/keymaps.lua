-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Replaced with vim-kitty-navigator
-- vim.keymap.set('n', '<A-n>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<A-o>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<A-e>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<A-i>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Replace selected text with previously deleted text
vim.keymap.set("x", "<leader>p", [["_dP]])
-- Move lines up and down
vim.keymap.set('n', '<A-S-e>', ':m .+1<CR>==', { desc = 'Move the current line down' })
vim.keymap.set('n', '<A-S-i>', ':m .-2<CR>==', { desc = 'Move the current line up' })

vim.keymap.set('n', '<leader>q', "<cmd>qa<cr>", { desc = "Quit All" })
-- FIXME: which-key breaks with this:
vim.keymap.set('n', '<leader>yy', "<cmd>%y<cr>", { desc = "Buffer" })
