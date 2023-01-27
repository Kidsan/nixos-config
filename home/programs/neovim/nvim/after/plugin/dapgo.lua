require('dap-go').setup({
    dap_configurations = {
      {
          type = "go",
          name = "Attach remote",
          mode = "remote",
          request = "attach",
      },
    }
})

vim.keymap.set("n", "<leader>dt", require('dap-go').debug_test)

require('dap.ext.vscode').load_launchjs(nil, {})
