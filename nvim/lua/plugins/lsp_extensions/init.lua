local autocmd = require 'autocmds'

autocmd.augroup({
    {
        'InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost',
        '*.rs',
        'lua require("lsp_extensions").inlay_hints { highlight = "Comment", prefix = " → ", aligned = false, only_current_line = false, enabled = { "ChainingHint", "TypeHint", "ParameterHint" } }',
    }
}, 'inlay_hints')
