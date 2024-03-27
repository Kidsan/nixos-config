return {
    {
        'mfussenegger/nvim-dap',
        lazy = true,
        dependencies = {
            { 'rcarriga/nvim-dap-ui' },
            { 'nvim-neotest/nvim-nio' }
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
                        name = "Debug",     -- Human readable name
                        request = "launch", -- Whether to "launch" or "attach" to program
                        program = "${file}",
                    },
                }
            }

            dap.adapters.go = {
                type = "server",
                port = "${port}",
                executable = {
                    command = vim.fn.stdpath("data") .. '/mason/bin/dlv',
                    args = { "dap", "-l", "127.0.0.1:${port}" },
                },
            }

            vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'Error' })

            -- Start debugging session
            vim.keymap.set("n", "<leader>ds", function()
                dap.continue()
                ui.toggle({})
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false) -- Spaces buffers evenly
            end)

            -- Set breakpoints, get variable values, step into/out of functions, etc.
            vim.keymap.set("n", "<leader>dl", require("dap.ui.widgets").hover)
            vim.keymap.set("n", "<leader>dc", dap.continue)
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint)
            vim.keymap.set("n", "<leader>dn", dap.step_over)
            vim.keymap.set("n", "<leader>di", dap.step_into)
            vim.keymap.set("n", "<leader>do", dap.step_out)
            vim.keymap.set("n", "<leader>dC", function()
                dap.clear_breakpoints()
                require("notify")("Breakpoints cleared", "warn", { title = "DAP" })
            end)

            -- Close debugger and clear breakpoints
            vim.keymap.set("n", "<leader>de", function()
                dap.clear_breakpoints()
                ui.toggle({})
                dap.terminate()
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-w>=", false, true, true), "n", false)
                require("notify")("Debugger session ended", "warn", { title = "DAP" })
            end)
        end
    }
}
