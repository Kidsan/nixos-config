return {
    {
        "lukas-reineke/indent-blankline.nvim",
        tag = "v2.20.8",
        event = { "BufReadPost", "BufNewFile" },
        opts = {
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
        },
    }
}
