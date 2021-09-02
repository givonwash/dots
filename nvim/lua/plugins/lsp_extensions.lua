return function()
    local autocmd = require 'autocmds'

    autocmd.augroup({
        {
            'InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost', '*.rs',
            'lua require("lsp_extensions").inlay_hints { highlight = "TSType", prefix = " → ", aligned = false, only_current_line = false, enabled = { "ChainingHint", "TypeHint", "ParameterHint" } }',
        },
    }, 'inlay_hints')
end
