local opt = require 'options'
opt.gset('completeopt', 'menuone,noselect')
opt.gset('shortmess', 'filnxtToOFc')

require('compe').setup {
    source = {
        buffer = true,
        path = true,
        spell = true,
        calc = true,
        nvim_lsp = true,
        nvim_lua = true,
        snippets_nvim = true,
    }
}
