return {
    'sontungexpt/buffer-closer',
    event = "VeryLazy",
    config = function()
        -- default values
        require("buffer-closer").setup({
            min_remaining_buffers = 3, -- can not be less than 1
            retirement_minutes = 3, -- can not be less than 1

            -- close the buffer when the given events are triggered (see :h autocmd-events)
            -- if the value is "default", the plugin will use the default events
            -- if the value is "disabled", the plugin will not use any events
            -- if the value is a table, the plugin will use the given events
            events = "default", -- (table, "default", "disabled"):

            timed_check = {
                enabled = true,
                interval_minutes = 1, -- can not be less than 1
            },

            excluded = {
                filetypes = { "lazy", "NvimTree", "mason" },
                buftypes = { "terminal", "nofile", "quickfix", "prompt", "help" },
                filenames = {},
            },

            -- it means that a buffer will not be closed if it is opened in a window
            ignore_working_windows = true,
        })
    end,
}
