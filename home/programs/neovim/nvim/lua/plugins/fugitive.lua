return {
    {
        'tpope/vim-fugitive',
        keys = {
            {
                "<leader>gs",
                mode = "n",
                function()
                    vim.cmd.Git
                end,
                desc = "Git Fugitive status"
            }
        }
    }
}
