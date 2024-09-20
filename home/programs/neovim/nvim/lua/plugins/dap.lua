return {
    {
        'mfussenegger/nvim-dap',
        lazy = true,
        dependencies = {
            { 'rcarriga/nvim-dap-ui' },
            { 'nvim-neotest/nvim-nio' },
            {'leoluz/nvim-dap-go'},
        },
        keys = {
            {"<leader>ds", mode = "n", function()
                require("dap").continue()
                require("dapui").toggle({})
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
            end, desc = "dap start"},
            { "<leader>dl",mode = "n", function() require("dap.ui.widgets").hover() end, desc = "dap ui hove"},
            { "<leader>dc",mode = "n", function() require("dap").continue() end, desc="dap continue"},
            { "<leader>db",mode = "n", function() require("dap").toggle_breakpoint() end, desc="dap breakpoint toggle"},
            { "<leader>dn",mode = "n", function() require("dap").step_over() end, desc=" dap step over"},
            { "<leader>di",mode = "n", function() require("dap").step_into() end, desc="dap step into"},
            { "<leader>do",mode = "n", function() require("dap").step_out() end, desc=" dap step out"},
            {"<leader>dC", mode = "n", function()
                require("dap").clear_breakpoints()
                require("notify")("Breakpoints cleared", "warn", { title = "DAP" })
            end, desc = "dap clear"},

            -- Close debugger and clear breakpoints
            {"<leader>de", mode = "n", function()
                require("dap").clear_breakpoints()
                require("dapui").toggle({})
                require("dap").terminate()
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
                require("notify")("Debugger session ended", "warn", { title = "DAP" })
            end, desc = ""},
        },
        config = function()
            local dap = require('dap')
            local ui = require('dapui')

            dap.set_log_level('INFO')

            ui.setup({
                icons = { expanded = "▾", collapsed = "▸" },
                mappings = {
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                expand_lines = vim.fn.has("nvim-0.7"),
                layouts = {
                    {
                        elements = {
                            "scopes",
                        },
                        size = 0.3,
                        position = "right"
                    },
                    {
                        elements = {
                            "repl",
                            "breakpoints"
                        },
                        size = 0.3,
                        position = "bottom",
                    },
                },
                floating = {
                    max_height = nil,
                    max_width = nil,
                    border = "single",
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
                render = {
                    max_type_length = nil,
                },
            })


            dap.configurations = {
                go = {
                    {
                        type = "go",        -- Which adapter to use
                        name = "Debug go file",     -- Human readable name
                        request = "launch", -- Whether to "launch" or "attach" to program
                        program = "${file}",
                    },
                }
            }

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

            dap.adapters.go = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath("data") .. '/mason/bin/dlv',
                    args = { "dap", "-l", "127.0.0.1:${port}" },
                },
            }

            vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'Error' })
        end
    }
}
