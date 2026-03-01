return {
    "neovim/nvim-lspconfig",
    config = function()
        for _, ls in pairs(require("config.language-servers")) do
            vim.lsp.enable(ls)
        end

        vim.keymap.set("n", "K", function ()
            vim.lsp.buf.hover({
                border = "rounded",
            })
        end, {})
        vim.keymap.set("n", "<leader>k", function()
            vim.diagnostic.open_float({
                border = "rounded",
            }) end, {})
        vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help({
                border = "rounded",
        }) end,	{})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,	{})
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition,	{})
        vim.keymap.set("n", "<leader>dl", vim.lsp.buf.declaration,	{})
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,			{})
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next,			{})
    end,
}
