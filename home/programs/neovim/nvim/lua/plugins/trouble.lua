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
                "<cmd>Trouble diagnostics<cr>",
                desc = "TroubleToggle"
            },
            {
                "<leader>xd",
                mode = "n",
                "<cmd>TroubleToggle document_diagnostics<cr>",
                desc =
                "Trouble document_diagnostics"
            },
            {
                "<leader>xl",
                mode = "n",
                "<cmd>Trouble loclist<cr>",
                desc = "Trouble loclist"
            },
            {
                "<leader>xq",
                mode = "n",
                "<cmd>Trouble quickfix<cr>",
                desc = "Trouble quickfix"
            },
            {
                "<leader>xR",
                mode = "n",
                "<cmd>Trouble lsp_references<cr>",
                desc =
                "Trouble lsp_references"
            },
        }
    }
}
