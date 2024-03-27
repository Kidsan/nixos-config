return {
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-file-browser.nvim',
                event = "VeryLazy",
                dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' }
            }
        },
        -- stylua: ignore
        keys = {
            {
                "<leader>pf",
                mode = "n",
                function() require("telescope.builtin").find_files() end,
                desc = "telescope find files"
            },
            {
                "<C-p>",
                mode = "n",
                function() require("telescope.builtin").git_files() end,
                desc = "telescope find files"
            },
            {
                "<leader>ps",
                mode = "n",
                function()
                    require("telescope.builtin").live_grep()
                end,
                desc = "telescope grep string"
            },
            {
                "<leader>pt",
                mode = "n",
                function()
                    require("telescope.builtin").treesitter()
                end,
                desc = "telescope treesitter"
            },
            {
                "<leader>pb",
                mode = "n",
                function() require("telescope.builtin").buffers() end,
                desc = "telescope buffers"
            },
        },
        config = function()
            local opts = {
                extensions = {
                    file_browser = {
                        respect_gitignore = false,
                        hijack_netrw = true,
                        hidden = true,
                    }
                }
            }
            require('telescope').setup(opts)
            require("telescope").load_extension "file_browser"
        end

    }
}
