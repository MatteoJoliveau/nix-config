local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, buffer)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = buffer })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = buffer })
    end,
  },
})
