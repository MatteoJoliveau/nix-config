local terminal = require("nvterm.terminal")

require('nvterm').setup {}

vim.keymap.set("n", "<leader>tt", function () require("nvterm.terminal").toggle "horizontal" end, { desc = 'Open [T]erminal' })
vim.keymap.set("n", "<leader>tf", function () require("nvterm.terminal").toggle "float" end, { desc = 'Open [F]loating [T]erminal' })
