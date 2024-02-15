return {
    {
        "zbirenbaum/copilot.lua",
        event = "BufEnter",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
        },
    },
    {
        "zbirenbaum/copilot-cmp",
        opts = {}
    }
}
