local cmp = require('cmp')

require('crates').setup()

cmp.setup({
    snippet = {
      expand = function(args)
        require('snippy').expand_snippet(args.body)
      end,
    },
    mapping = {
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        -- Add tab support
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        -- Add arrows support
        ["<Up>"] = cmp.mapping.select_prev_item(),
        ["<Down>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'snippy' },
      { name = 'path' },
      { name = 'buffer' },
      { name = 'crates' },
    })
  })
