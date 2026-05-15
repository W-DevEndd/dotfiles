return {
    'romgrk/barbar.nvim',
    branch = 'main',
    dependencies = {
        "ojroques/nvim-bufdel",
        'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    -- opt = {
    -- },
    config = function ()
        -- require("barbar").setup()
        -- local barbar = require("barbar")
        require("bufdel").setup({ quit = false })
        -- barbar.enable()
        -- barbar.setup({
        --     animation = false,
        --     insert_at_start = true,
        --     maximum_length = 30,
        --     maximum_padding = 30,
        -- })
        -- Buffer Bar Bar
        vim.api.nvim_set_keymap("n", "<leader>bd", ":BufDel<CR>",			  { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>bp", ":BufferPin<CR>",			  { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "[b",		   ":BufferPrevious<CR>",	  { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "]b",		   ":BufferNext<CR>",		  { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "[[b",		   ":BufferMovePrevious<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "]]b",		   ":BufferMoveNext<CR>",	  { noremap = true, silent = true })

        -- Tab
        vim.api.nvim_set_keymap("n", "]t", ":tabnext<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "[t", ":tabprevious<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>td", ":tabclose<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>tn", ":tabnew<CR>", { noremap = true, silent = true })
    end,
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
}
