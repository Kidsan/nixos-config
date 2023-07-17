-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        'nvim-telescope/telescope-file-browser.nvim',
        requires = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons' }
    }

    use({
        'dracula/vim',
        as = 'dracula',
        config = function()
            vim.cmd('colorscheme dracula')
        end
    })

    use('nvim-treesitter/playground')
    use('tpope/vim-fugitive')


    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            -- Snippet Collection (Optional)
            { 'rafamadriz/friendly-snippets' },

        }
    }

    use 'simrat39/rust-tools.nvim'
    use { 'ray-x/go.nvim',
        requires = {
            { 'ray-x/guihua.lua' },
            { 'theHamsta/nvim-dap-virtual-text' }
        }
    }
    use { 'windwp/nvim-autopairs' }
    use 'lewis6991/gitsigns.nvim'
    use({
        "luukvbaal/statuscol.nvim",
        config = function()
            require("statuscol").setup({
                setopt = true,
            })
        end
    })
    use 'mfussenegger/nvim-dap'
    use { 'rcarriga/nvim-dap-ui', requires = { 'mfussenegger/nvim-dap' } }
    use 'rcarriga/nvim-notify'

    use 'leoluz/nvim-dap-go'

    use 'nvim-tree/nvim-web-devicons'

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    -- done as far as here

    use {
        'renerocksai/telekasten.nvim',
        requires = { 'nvim/telescope/telescope.nvim', 'renerocksai/calendar-vim' }
    }

    use 'numToStr/Comment.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use { 'folke/trouble.nvim', requires = 'nvim-tree/nvim-web-devicons' }
    use 'windwp/nvim-ts-autotag'
    -- use { 'nvim-telescope/telescope-ui-select.nvim' }
    use 'lukas-reineke/indent-blankline.nvim'
    use {
        'folke/which-key.nvim',
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 1000
            require("which-key").setup {

            }
        end
    }
    use 'folke/flash.nvim'
end)
