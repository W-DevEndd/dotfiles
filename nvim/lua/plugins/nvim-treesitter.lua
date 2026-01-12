return {
	"nvim-treesitter/nvim-treesitter",
	branch = 'master',
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = require("treesitter"),
			-- sync_install = false,
			auto_install = true,
			-- ignore_install = {},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			fold = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
