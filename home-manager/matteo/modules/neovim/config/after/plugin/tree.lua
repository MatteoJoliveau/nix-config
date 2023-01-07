local tree = require('nvim-tree')

tree.setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
})

vim.keymap.set('n', 'tt', tree.toggle)
