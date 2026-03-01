
-- Leader key
vim.g.mapleader = ' ' -- Space as the leader key
vim.api.nvim_set_keymap('n', '<Leader>w', ':w<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<Leader>rlb', ':e %<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>cbd', ':e %:p:h<CR>', { noremap = true, silent = true })
