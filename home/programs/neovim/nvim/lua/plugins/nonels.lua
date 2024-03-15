return {
    'nvimtools/none-ls.nvim',
    ft = "python",
    opts = function(_, opts)
        local nls = require("null-ls")
        opts.sources = vim.list_extend(opts.sources or {}, {
            nls.builtins.code_actions.gitsigns,
            -- ts
            nls.builtins.formatting.biome,
            -- other
            nls.builtins.formatting.stylua,
            nls.builtins.formatting.shfmt,
            nls.builtins.formatting.black
        })
        return opts
    end

}
