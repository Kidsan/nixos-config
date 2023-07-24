return {
    {
        'tpope/vim-fugitive',
        lazy = true,
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
