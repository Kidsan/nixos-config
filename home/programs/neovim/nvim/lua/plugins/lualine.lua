return {
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-tree/nvim-web-devicons', optional = true },
        opts = {
            options = {
                theme = 'dracula',
            }
        }
    }
}
