local go_package = function()
    for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, true)) do
        if line:match("^package ") then
            return "⬡ " .. string.sub(line, 9);
        end
    end
    return ""
end

return {
    {
        'nvim-lualine/lualine.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-tree/nvim-web-devicons', optional = true },
        opts = {
            options = {
                theme = 'dracula',
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { {
                    go_package,
                    cond = function()
                        return vim.bo.filetype == "go"
                    end
                },
                    { 'filename' }
                },
                lualine_x = {
                    'encoding',
                    'fileformat',
                    'filetype'
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
        }
    }
}
