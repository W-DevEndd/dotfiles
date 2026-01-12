return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = require("language-servers"),
		},
		config = function()
			local lspconfig = vim.lsp.config
			local lspenable = vim.lsp.enable
			-- local lsputil = vim.lsp.util

			for _, server in pairs(require("language-servers")) do
				-- lspconfig(server, {})
				lspenable(server)
			end

			lspconfig("ts_ls", {
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescriptreact",
					"typescript.tsx",
				},
			})

			lspconfig("clangd", {
				-- Optional: add any specific clangd arguments here
				-- cmd = { "clangd", "--query-driver=/usr/bin/gcc" },
				-- root_dir = require('lspconfig.util').root_pattern('.git', 'compile_commands.json', '.clangd'),
			})

			lspconfig("jsonls", {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			})

			lspconfig("yamlls", {
				settings = {
					yaml = {
						schemaStore = {
							-- You must disable built-in schemaStore support if you want to use
							-- this plugin and its advanced options like `ignore`.
							enable = false,
							-- Avoid TypeError: Cannot read properties of undefined (reading 'length')
							url = "",
						},
						schemas = require("schemastore").yaml.schemas(),
					},
				},
			})
		end,
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {
					ui = {
						icons = {
							package_installed = "✓",
							package_pending = "➜",
							package_uninstalled = "✗",
						},
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	-- {
	--     'nvimdev/lspsaga.nvim',
	--     config = function()
	--         require('lspsaga').setup({})
	--     end,
	--     dependencies = {
	--         'nvim-treesitter/nvim-treesitter', -- optional
	--         'nvim-tree/nvim-web-devicons',     -- optional
	--     }
	-- }
}
