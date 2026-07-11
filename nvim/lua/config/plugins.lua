return {
    -- Interfacce
    require("config.plugins.catppuccin"),
    require("config.plugins.neo-tree"),
    require("config.plugins.mason"),
    require("config.plugins.lualine"),
    require("config.plugins.telescope"),
    require("config.plugins.barbar"),
    require("config.plugins.toggleterm"),
    require("config.plugins.neogit"),

    -- Feature
    require("config.plugins.nvim-lspconfig"),
    require("config.plugins.nvim-cmp"),
    require("config.plugins.nvim-autopairs"),
    require("config.plugins.autosave"),
    require("config.plugins.cord"),

    -- Code view
    require("config.plugins.nvim-treesitter"),
    require("config.plugins.rainbow-delimiters"),
    require("config.plugins.indent-blankline"),
    require("config.plugins.schemastore"),
    require("config.plugins.nvim-colorizer"),
}
