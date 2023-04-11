local tree = require('neo-tree')

tree.setup {
  filesystem = {
    follow_current_file = true,
  },
}

vim.keymap.set("n", "tt", "<cmd>:Neotree toggle left show<cr>", { desc = 'Neotree: Toggle tree' })
vim.keymap.set("n", "<leader>tr", "<cmd>:Neotree left reveal_force_cwd<cr>", { desc = 'Neotree: Reveal in tree' })
