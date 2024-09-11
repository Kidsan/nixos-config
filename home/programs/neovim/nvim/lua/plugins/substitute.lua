return {
    'gbprod/substitute.nvim',
    keys = {
        { "<leader>r",  mode = "n", function() require('substitute').operator() end, desc = "substitute w/ motion" },
        { "<leader>rr", mode = "n", function() require('substitute').line() end,     desc = "substitute w/ line" },
        { "<leader>R",  mode = "n", function() require('substitute').eol() end,      desc = "substitute w/ eol" },
        { "<leader>r",  mode = "x", function() require('substitute').visual() end,   desc = "substitute w/ visual" },
    },
    opts = {

    },
}
