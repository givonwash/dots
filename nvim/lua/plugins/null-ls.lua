return function()
    local nls = require 'null-ls'
    local lsp = require 'lsp'

    nls.setup {
        sources = {
            nls.builtins.formatting.stylua,
            nls.builtins.formatting.black,
            nls.builtins.formatting.isort,
            nls.builtins.formatting.prettier,
        },
        on_attach = lsp.on_attach,
    }
end
