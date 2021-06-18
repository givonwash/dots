local opt = vim.opt
opt.completeopt = { 'menuone', 'noselect' }
opt.shortmess:append('c')

require('compe').setup {
    source = {
        buffer = true,
        path = true,
        spell = true,
        calc = true,
        nvim_lsp = true,
        nvim_lua = true,
        snippets_nvim = true,
    },
}
