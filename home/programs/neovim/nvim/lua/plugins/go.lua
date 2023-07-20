return {
    {
        'ray-x/go.nvim',
        ft = "go",
        dependencies = {
            { 'ray-x/guihua.lua' },
            { 'theHamsta/nvim-dap-virtual-text' }
        },
        config = function()
            local opts = {
                luasnip = true,
            }
            require('go').setup(opts)
            local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*.go",
                callback = function()
                    require('go.format').goimport()
                end,
                group = format_sync_grp,
            })
        end
    }
}
