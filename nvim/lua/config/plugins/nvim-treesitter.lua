
return {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
        "kevinhwang91/nvim-ufo",
        "kevinhwang91/promise-async",
    },

    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
	    require('nvim-treesitter').setup({
		    auto_install = true,
		    ensure_installed = { "lua", "vim", "vimdoc" },
		    highlight = {
			    enable = true,
            },

            rainbow = {
                enable = true,
                -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                max_file_lines = nil, -- Do not enable for files with more than n lines, int
                -- colors = {}, -- table of hex strings
                -- termcolors = {} -- table of colour name strings
            }
	    })

        -- ufo
        vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

        local ufo = require('ufo')

        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' ⋯ %d lines '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    table.insert(newVirtText, {chunkText, chunk[2]})
                    table.insert(newVirtText, {suffix, 'MoreMsg'})
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            return newVirtText
        end

        ufo.setup({
            fold_virt_text_handler = handler,
            provider_selector = function(bufnr, filetype, buftype)
                return {'treesitter', 'indent'}
            end
        })

    end
}
