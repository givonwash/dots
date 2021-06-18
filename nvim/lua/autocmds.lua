local cmd = vim.cmd

local M = {}

function M.augroup(autocmds, name)
    cmd('augroup ' .. name)
    cmd('autocmd!')
    for _, au in pairs(autocmds) do cmd('autocmd ' .. table.concat(au, ' ')) end
    cmd('augroup end')
end

M.augroup({
    { 'BufWinEnter', '*', 'set formatoptions-=ro' },
    { 'FileType', 'help,man', 'wincmd L' },
    { 'BufWritePre', '*', 'mark ` | %s:\\v\\s+$::ge | normal! ``' },
}, 'vimrc')

return M
