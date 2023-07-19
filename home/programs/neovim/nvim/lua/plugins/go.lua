return {
    {
        'ray-x/go.nvim',
        dependencies = {
            { 'ray-x/guihua.lua' },
            { 'theHamsta/nvim-dap-virtual-text' }
        },
        opts = {
            luasnip = true,
        },
        init = function()
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
