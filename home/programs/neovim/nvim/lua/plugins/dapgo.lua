return {
    {
        'leoluz/nvim-dap-go',
        ft = "go",
        dependencies = {
            { 'mfussenegger/nvim-dap' }
        },
        keys = {
            { "<leader>dt", mode = "n", function() require('dap-go').debug_test() end, desc = "dapgo debug test" },
        },
        config = function()
            local opts = {
                dap_configurations = {
                    {
                        type = "go",
                        name = "Attach remote",
                        mode = "remote",
                        request = "attach",
                    },
                }
            }
            require('dap-go').setup(opts)
            require('dap.ext.vscode').load_launchjs(nil, {})
        end
    }
}
