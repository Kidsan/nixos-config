return {
    {
        'mrcjkb/rustaceanvim',
        version = "^3",
        event = { "BufReadPost *.rs" },
        keys = {
            { "<Leader>a", mode = "n", function() vim.cmd.RustLsp('codeAction') end, { buffer = vim.api.nvim_get_current_buf() }, desc = "LSP Code Action" },
        },
        config = function()
            vim.g.rustaceanvim = {
                tools = {
                    inlay_hints = {
                        auto = false,
                        highlight = "Debug",
                    },
                    hover_actions = {
                        auto_focus = true,
                    },
                },
                server = {
                    settings = {
                        ["rust-analyzer"] = {
                            checkOnSave = {
                                enable = true,
                                command = "clippy",
                            },
                            cargo = {
                                allFeatures = true,
                            }
                        },
                    },
                    on_attach = function(client, _)
                        client.server_capabilities.semanticTokensProvider = nil
                    end,
                }
            }
        end
    }
}
