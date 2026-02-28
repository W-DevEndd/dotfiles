
return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            auto_install = true -- Ensure essential parsers are installed
        })
    end,
}
