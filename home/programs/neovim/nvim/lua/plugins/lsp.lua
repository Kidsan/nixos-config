return {
    {
        'VonHeikemen/lsp-zero.nvim',
        event = { "BufReadPre", "BufNewFile" },
        branch = 'v2.x',
        dependencies = {
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

            { 'onsails/lspkind.nvim' },

        },
        config = function()
            local lsp = require('lsp-zero')
            lsp.preset('recommended')

            -- don't initialize this language server
            -- we will use rust-tools to setup rust_analyzer
            lsp.skip_server_setup({ 'rust_analyzer' })

            local cmp = require('cmp')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            local cmp_mappings = lsp.defaults.cmp_mappings({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            })

            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on(
                'confirm_done',
                cmp_autopairs.on_confirm_done()
            )

            local lspkind = require("lspkind")

            lsp.setup_nvim_cmp({
                mapping = cmp_mappings,
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 75,
                        ellipsis_char = '...',
                        symbol_map = {
                            Copilot = "",
                        },
                    })
                },
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'copilot' },
                    { name = 'path' },
                    { name = 'luasnip' },
                }
            })

            local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

            parser_config.nu = {
                install_info = {
                    url = "https://github.com/nushell/tree-sitter-nu",
                    files = { "src/parser.c" },
                    branch = "main",
                },
                filetype = "nu",
            }

            local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function()
                    vim.lsp.buf.format({ timeout_ms = 200 })
                end,
                group = format_sync_grp,
            })

            lsp.on_attach(function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
                vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
                vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
                vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
                vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
                vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
                vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
                vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
            end)

            lsp.configure('nil_ls', {
                settings = {
                    ['nil'] = {
                        formatting = { command = { "nixpkgs-fmt" } }
                    }
                }
            })

            lsp.configure('nushell', {
                command = { "nu", "--lsp" },
                filetypes = { "nu" },
                root_dir = require("lspconfig.util").find_git_ancestor,
                singe_file_support = true,
            })

            lsp.configure('volar', {
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' }
            })

            lsp.set_server_config({
                on_init = function(client)
                    client.server_capabilities.semanticTokensProvider = nil
                end,
            })

            lsp.nvim_workspace()
            lsp.setup()

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = true,
                underline = true,
                severity_sort = false,
                float = true,
            })
        end
    }
}
