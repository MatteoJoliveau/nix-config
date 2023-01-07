-- Reserve space for diagnostic icons
vim.opt.signcolumn = 'yes'

local lsp = require('lsp-zero')
lsp.preset('recommended')

-- Install these servers
lsp.ensure_installed({
  'tsserver',
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

-- Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

-- Turn on lsp status information
require('fidget').setup()
