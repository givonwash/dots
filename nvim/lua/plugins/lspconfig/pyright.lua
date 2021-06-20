local pyright = require('lspconfig').pyright

pyright.setup {
    settings = { python = { analysis = { typeCheckingMode = 'strict' } } },
}
