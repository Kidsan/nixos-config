return {
    {
        'tpope/vim-fugitive',
        opts = {},
        event = "VeryLazy",
        keys = {
            {
                "<leader>gs",
                mode = "n",
                function()
                    vim.cmd.Git()
                end,
                desc = "Git Fugitive status"
            }
        }
    }
}
