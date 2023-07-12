local flash = require("flash")
flash.setup({})
vim.keymap.set({ "n", "x", "o" }, "s", function()
        flash.jump({
            search = {
                mode = function(str)
                    return "\\<" .. str
                end
            }
        })
    end,
    { desc = "Flash" })
vim.keymap.set({ "n", "o", "x" }, "S", function() flash.treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() flash.remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", function() flash.treesitter_search() end, { desc = "Flash Treesitter Search" })
vim.keymap.set({ "c" }, "<c-s>", function() flash.toggle() end, { desc = "Toggle Flash Search" })
