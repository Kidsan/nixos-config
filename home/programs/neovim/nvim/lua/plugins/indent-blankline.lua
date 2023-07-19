return {
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
        },
        init = function()
            vim.opt.list = true
            vim.opt.listchars:append "space:."
            vim.opt.listchars:append "eol:󱞣"
        end
    }
}
