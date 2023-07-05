local rt = require("rust-tools")

rt.setup({
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
        on_attach = function(client, bufnr)
            client.server_capabilities.semanticTokensProvider = nil
            -- Hover actions
            vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
            -- Code action groups
            vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
            vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
            vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
            vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
            vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
            vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
        end,
    },
})
