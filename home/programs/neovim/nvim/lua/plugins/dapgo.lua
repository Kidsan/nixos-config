return {
    {
        'leoluz/nvim-dap-go',
        ft = "go",
        dependencies = {
            { 'mfussenegger/nvim-dap' }
        },
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
            { "<leader>dt", mode = "n", function() require('dap-go').debug_test() end, desc = "dapgo debug test" },
        }
    }
}
