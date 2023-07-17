return {
    {
        "dracula/vim",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd([[colorscheme dracula]])
        end
    },
}
