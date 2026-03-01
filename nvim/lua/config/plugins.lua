return {
    -- Interfacce
    require("config.plugins.catppuccin"),
    require("config.plugins.neo-tree"),
    require("config.plugins.mason"),
    require("config.plugins.lualine"),
    require("config.plugins.telescope"),
    require("config.plugins.barbar"),
    require("config.plugins.toggleterm"),

    -- Feature
    require("config.plugins.nvim-lspconfig"),
    require("config.plugins.nvim-cmp"),
    require("config.plugins.nvim-autopairs"),
    require("config.plugins.autosave"),

    -- Code view
    require("config.plugins.nvim-treesitter"),
    require("config.plugins.rainbow-delimiters"),
}
