return {
    {
        'leoluz/nvim-dap-go',
        opts = {
            dap_configurations = {
                {
                    type = "go",
                    name = "Attach remote",
                    mode = "remote",
                    request = "attach",
                },
            }

        },
        keys = {
            { "<leader>dt", require('dap-go').debug_test, desc = "dapgo debug test" },
        },
        init = function()
            require('dap.ext.vscode').load_launchjs(nil, {})
        end

    }
}
