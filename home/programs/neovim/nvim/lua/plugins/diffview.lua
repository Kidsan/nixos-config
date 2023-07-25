return {
    "sindrets/diffview.nvim",
    lazy = true,
    opts = {},
    keys = {
        {
            "<leader><leader>v",
            mode = "n",
            function()
                if next(require('diffview.lib').views) == nil then vim.cmd('DiffviewOpen') else vim.cmd('DiffviewClose') end
            end,
            desc = "diffview"
        }
    }
}
