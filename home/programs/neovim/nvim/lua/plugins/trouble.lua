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
                "<cmd>Trouble diagnostics toggle<cr>",
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
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Trouble loclist"
            },
            {
                "<leader>xq",
                mode = "n",
                "<cmd>Trouble quickfix toggle<cr>",
                desc = "Trouble quickfix"
            },
            {
                "<leader>xR",
                mode = "n",
                "<cmd>Trouble lsp_references toggle<cr>",
                desc =
                "Trouble lsp_references"
            },
        }
    }
}
