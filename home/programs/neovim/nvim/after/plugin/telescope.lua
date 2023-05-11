require("telescope").setup {
    extensions = {
        -- ["ui-select"] = {
        --     require("telescope.themes").get_dropdown {
        --
        --     }
        -- },
        file_browser = {
            respect_gitignore = false,
            hijack_netrw = true,
            hidden = true,
        }
    }
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

require("telescope").load_extension "file_browser"
-- require("telescope").load_extension("ui-select")
