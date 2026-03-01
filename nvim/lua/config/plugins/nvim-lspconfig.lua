return {
    "neovim/nvim-lspconfig",
    config = function()
        for _, ls in pairs(require("config.language-servers")) do
            vim.lsp.enable(ls)
        end
    end,
}
