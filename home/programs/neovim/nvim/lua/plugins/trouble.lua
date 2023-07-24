return {
    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        lazy = true,
        opts = {},
        keys = {
            {
                "<leader>xx",
                mode = "n",
                "<cmd>TroubleToggle<cr>",
                desc = "TroubleToggle"
            },
            {
                "<leader>xw",
                mode = "n",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                desc =
                "TroubleToggle workspace_diagnostics"
            },
            {
                "<leader>xd",
                mode = "n",
                "<cmd>TroubleToggle document_diagnostics<cr>",
                desc =
                "TroubleToggle document_diagnostics"
            },
            {
                "<leader>xl",
                mode = "n",
                "<cmd>TroubleToggle loclist<cr>",
                desc = "TroubleToggle loclist"
            },
            {
                "<leader>xq",
                mode = "n",
                "<cmd>TroubleToggle quickfix<cr>",
                desc = "TroubleToggle quickfix"
            },
            {
                "<leader>xR",
                mode = "n",
                "<cmd>TroubleToggle lsp_references<cr>",
                desc =
                "TroubleToggle lsp_references"
            },
        }
    }
}
