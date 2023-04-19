local neogit = require('neogit')

neogit.setup {
 integrations = {
    diffview = true
  }
}

vim.keymap.set('n', '<leader>gg', neogit.open, { desc = 'Open [G]it' })
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = 'Open [G]it [D]iffview' })

require('gitsigns').setup()
