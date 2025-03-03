return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
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
                "<leader>b",
                mode = "n",
                function() require("telescope.builtin").buffers() end,
                desc = "telescope buffers"
            },
            {
                "<leader>pv",
                mode = "n",
                function() require("telescope").extensions.file_browser.file_browser() end,
                desc = "telescope file browser"
            },
            {
                "<leader>pr",
                mode = "n",
                function() require("telescope.builtin").resume() end,
                desc = "telescope resume",
            }
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
