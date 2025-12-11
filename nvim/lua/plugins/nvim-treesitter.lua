return {
	"nvim-treesitter/nvim-treesitter",
	-- dependencies = {
	-- 	{
	-- 		"davidmh/mdx.nvim",
	-- 		config = true,
	-- 	},
	-- },
	-- branch = 'master',
	-- lazy = false,
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
			-- rainbow = {
			--     enable = true,
			--     extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
			--     max_file_lines = nil, -- Do not enable for files with more than n lines, int
			--     colors = {
			--         '#c6a0f6', -- Mauve (Ví dụ cho cấp 1)
			--         '#f38ba8', -- Red (Ví dụ cho cấp 2)
			--         '#fab387', -- Peach (Ví dụ cho cấp 3)
			--         '#f9e2af', -- Yellow (Ví dụ cho cấp 4)
			--         '#a6e3a1', -- Green (Ví dụ cho cấp 5)
			--         '#89b4fa', -- Blue (Ví dụ cho cấp 6)
			--         '#b4befe', -- Lavender (Ví dụ cho cấp 7)
			--     },
			--     -- termcolors = {
			--     --     12,  -- Mauve
			--     --     13,  -- Peach
			--     --     14,  -- Green
			--     --     15,  -- Blue
			--     --     16,  -- Lavender
			--     --     17,  -- Yellow
			--     -- } -- table of colour name strings
			-- }
		})
	end,
}
