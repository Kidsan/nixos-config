local lsp = require('lsp-zero')
lsp.preset('recommended')

lsp.ensure_installed({
'rust_analyzer',
'gopls',
'nil_ls',
'lua_ls',
'terraform_ls'
})

-- don't initialize this language server
-- we will use rust-tools to setup rust_analyzer
lsp.skip_server_setup({'rust_analyzer'})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({select = true }),
	['<C-Space>'] = cmp.mapping.complete(),
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)


lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})


local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 200 })
  end,
  group = format_sync_grp,
})

lsp.on_attach(function(client, bufnr)

 local opts = {buffer = bufnr, remap = false}

 vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
 vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
 vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
 vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
 vim.keymap.set("n", "[d", vim.diagnostic.goto_next, opts)
 vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, opts)
 vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
 vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
 vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
 vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
 
 end)

lsp.configure('nil_ls', {
    settings = {
        ['nil'] = {
            formatting = { command = { "nixpkgs-fmt" } }
        }
    }
})

lsp.nvim_workspace()
lsp.setup()

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  float = true,
})
