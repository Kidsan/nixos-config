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
                lsp_cfg = true,
                lsp_semantic_highlights = false,
                lsp_inlay_hints = {
                    enable = false,
                },
                diagnostic = {
                    virtual_text = true,
                    signs = true,
                    update_in_insert = true,
                    underline = true,
                    severity_sort = false,
                    float = true,
                },
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
