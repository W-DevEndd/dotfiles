return {
    "neovim/nvim-lspconfig",
    config = function()
        for _, ls in pairs(require("config.language-servers")) do
            vim.lsp.enable(ls)
        end

        vim.keymap.set("n", "K", vim.lsp.buf.hover,					{})
        vim.keymap.set("n", "<leader>k", vim.diagnostic.open_float, {})
        vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help,	{})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,	{})
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition,	{})
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,			{})
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next,			{})
    end,
}
