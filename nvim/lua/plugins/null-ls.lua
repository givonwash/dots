return function()
    local nls = require 'null-ls'
    nls.setup {
        sources = {
            nls.builtins.formatting.stylua,
            nls.builtins.formatting.black,
            nls.builtins.formatting.isort,
            nls.builtins.formatting.prettier,
        },
    }
end
