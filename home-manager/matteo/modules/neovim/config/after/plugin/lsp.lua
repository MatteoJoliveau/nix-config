local lspconfig = require('lspconfig')
local mason_lsp = require('mason-lspconfig');
local telescope = require('telescope.builtin')

require('mason').setup()
mason_lsp.setup {
    ensure_installed = {
        -- 'rust_analyzer', -- installed by Nix
        -- 'elixirls',      -- installed by Nix
        'elmls',
        'dockerls',
        'docker_compose_language_service',
        'html',
        'marksman',
        'sqlls',
        'svelte',
        'taplo',
        'yamlls',
        'tsserver',
        'rnix',
        'jsonls',
        'lua_ls',
        'cssls',
        'diagnosticls'
     },
}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function on_attach(client, bufnr)
    local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end
    
        vim.keymap.set('n', keys, func, { buffer = bufnr, noremap = true, silent = true, desc = desc })
      end

    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('gr', telescope.lsp_references, '[G]oto [R]eferences')
    nmap('<leader>d', telescope.diagnostics, 'Diagnostic')
    nmap('<leader>e', vim.diagnostic.open_float, 'Open Floating [E]rror')
    nmap('[d', vim.diagnostic.goto_prev, 'Go to Previous Diagnostic')
    nmap(']d', vim.diagnostic.goto_next, 'Go to Next Diagnostic')
    nmap("<leader>f", vim.lsp.buf.format, '[F]ormat buffer')
    nmap("<M-CR>", vim.lsp.buf.code_action, 'Code Action')
end

for _, server_name in ipairs(mason_lsp.get_installed_servers()) do
    lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
    })
end

-- Turn on lsp status information
require('fidget').setup()



require("rust-tools").setup {
    tools = {
      runnables = {
        use_telescope = true,
      },
      inlay_hints = {
        auto = true,
        show_parameter_hints = false,
        parameter_hints_prefix = "",
        other_hints_prefix = "",
      },
    },
    server = {
      on_attach = on_attach,
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
          },
          files = {
            watcher = "server",
          },
        },
      },
    }, 
}
