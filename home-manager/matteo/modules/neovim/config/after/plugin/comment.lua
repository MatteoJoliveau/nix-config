require'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true,
    config = {
      nix = '# %s',
      rust = '// %s',
    }
  }
}

require('nvim_comment').setup({
  hook = function()
      require("ts_context_commentstring.internal").update_commentstring()
  end
})
