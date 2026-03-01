return {
    -- amongst your other plugins
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function ()
        require("toggleterm").setup()

        vim.api.nvim_set_keymap("n", "<leader>tf", ":ToggleTerm direction=float<CR>",	   { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>th", ":ToggleTerm direction=horizontal<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>tv", ":ToggleTerm direction=vertical<CR>",   { noremap = true, silent = true })
    end
}
