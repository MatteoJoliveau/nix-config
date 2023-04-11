require("trouble").setup {}

local nmap = function(keys, func, desc)
    if desc then
        desc = 'Trouble: ' .. desc
    end

    vim.keymap.set('n', keys, func, { noremap = true, silent = true, desc = desc })
end

nmap("<leader>xx", "<cmd>TroubleToggle<cr>", 'Toggle')
nmap('<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', 'Toggle [W]orkspace Diagnostics')
nmap('<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', 'Toggle [D]ocument Diagnostics')
nmap('<leader>xq', '<cmd>TroubleToggle quickfix<cr>', 'Toggle [Q]uickfixes')
nmap('<leader>xl', '<cmd>TroubleToggle loclist<cr>', 'Toggle [L]oclist')
nmap('gR', '<cmd>TroubleToggle lsp_references<cr>', 'Toggle [R]eferences')