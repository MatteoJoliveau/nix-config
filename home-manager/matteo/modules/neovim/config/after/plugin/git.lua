local neogit = require('neogit')

neogit.setup {}

vim.keymap.set('n', '<leader>gg', neogit.open, { desc = 'Open [G]it' })

require('gitsigns').setup()
