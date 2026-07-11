return {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
        -- Only one of these is needed.
        "sindrets/diffview.nvim",        -- optional
        "esmuellert/codediff.nvim",      -- optional

        -- For a custom log pager
        "m00qek/baleia.nvim",            -- optional

        -- Only one of these is needed.
        "nvim-telescope/telescope.nvim", -- optional
        "ibhagwan/fzf-lua",              -- optional
        "nvim-mini/mini.pick",           -- optional
        "folke/snacks.nvim",             -- optional
    },
    cmd = "Neogit",
    keys = {
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    },
    options = function ()
        local neogit = require('neogit')

        -- open using defaults
        neogit.open()

        -- open a specific popup
        neogit.open({ "commit" })

        -- open as a split
        neogit.open({ kind = "split" })

        -- open with different project
        neogit.open({ cwd = "~" })

        -- You can map this to a key
        vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Open Neogit UI" })

        -- Wrap in a function to pass additional arguments
        vim.keymap.set(
            "n",
            "<leader>gg",
            function() neogit.open({ kind = "split" }) end,
            { desc = "Open Neogit UI" }
        )
    end,
}
