local tree = require('nvim-tree')

tree.setup({
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true
  },
  filters = { dotfiles = false, custom = { '^.git$' }},
  git = {
    enable = true,
    ignore = false,
  },
  view = {
    renderer = {
      icons = {
        git_placement = "after",
      },
    },
  },
})

vim.keymap.set('n', 'tt', tree.toggle)
