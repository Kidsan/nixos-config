return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            extensions = {
                file_browser = {
                    respect_gitignore = false,
                    hijack_netrw = true,
                    hidden = true,
                }
            }
        },
        -- stylua: ignore
        keys = {
            {
                "<leader>pf",
                mode = "n",
                function() require("telescope.builtin").find_files end,
                desc = "telescope find files"
            },
            {
                "<C-p>",
                mode = "n",
                function() require("telescope.builtin").git_files end,
                desc = "telescope find files"
            },
            {
                "<leader>ps",
                mode = "n",
                function()
                    require("telescope.builtin").grep_string({
                        search = vim.fn.input("Grep > ")
                    })
                end,
                desc = "telescope grep string"
            },
        },
        init = function()
            require("telescope").load_extension "file_browser"
        end

    },
    {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' }
    }
}
