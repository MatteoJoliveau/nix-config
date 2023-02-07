-- Reserve space for diagnostic icons
vim.opt.signcolumn = 'yes'

local lsp = require('lsp-zero')
local nvim_lsp = require('lspconfig')

lsp.preset('recommended')

-- Install these servers
lsp.ensure_installed({
  'tsserver',
  'denols',
  'eslint',
  'sumneko_lua',
  'rust_analyzer',
  'elixirls',
  'bashls',
  'html',
  'cssls',
  'solargraph',
  'jsonls',
  'rnix',
  'svelte',
  'yamlls',
  'ltex',
  'marksman',
})

lsp.configure('denols', {
  root_dir = nvim_lsp.util.root_pattern("deno.json"),
  init_options = {
    lint = true,
  },
})

lsp.configure('tsserver', {
  root_dir = nvim_lsp.util.root_pattern("package.json"),
  init_options = {
    lint = true,
  },
})

-- Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

-- Turn on lsp status information
require('fidget').setup()

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { silent = true })
vim.keymap.set("n", "<M-CR>", vim.lsp.buf.code_action, { silent = true })

