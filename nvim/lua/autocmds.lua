local cmd = vim.cmd

local M = {}

function M.augroup(autocmds, name)
    cmd('augroup ' .. name)
    cmd 'autocmd!'
    for _, au in pairs(autocmds) do
        cmd(au)
    end
    cmd 'augroup end'
end

M.augroup({
    [[au FileType help,man wincmd L]],
    [[au BufWritePre * mark ` | %s:\v\s+$::ge | normal! ``]],
    [[au TextYankPost * silent! lua vim.highlight.on_yank() ]],
}, 'vimrc')

return M
