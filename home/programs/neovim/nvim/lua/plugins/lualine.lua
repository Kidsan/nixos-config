return {
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-tree/nvim-web-devicons', optional = true },
        opts = {
            options = {
                theme = 'dracula',
            },
            -- sections = {
            --     lualine_x = {
            --         {
            --
            --             require("lazy.status").updates,
            --             cond = require("lazy.status").has_updates,
            --             color = { fg = "#ff9e64" }
            --         }
            --     }
            -- }
        }
    }
}
