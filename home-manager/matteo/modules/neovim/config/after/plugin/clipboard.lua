local opts = { silent = true, remap = false }
-- Copy to clipboard
vim.keymap.set("v", "<leader>y", "+y", opts)
vim.keymap.set("n", "<leader>Y", "+yg_", opts)
vim.keymap.set("n", "<leader>y", "+y", opts)

-- Paste from clipboard
vim.keymap.set("n", "<leader>p", "+p", opts)
vim.keymap.set("n", "<leader>P", "+P", opts)
vim.keymap.set("v", "<leader>p", "+p", opts)
vim.keymap.set("v", "<leader>P", "+P", opts)
