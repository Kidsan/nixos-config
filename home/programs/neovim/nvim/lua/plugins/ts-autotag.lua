return {
    {
        "windwp/nvim-ts-autotag",
        opts = {},
        event = "BufReadPre",
        config = function()
            require("nvim-ts-autotag").setup()
        end,

    }
}
