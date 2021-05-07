local cmd = vim.cmd

local M = {}

function M.augroup(autocmds, name)
    cmd('augroup ' .. name)
    cmd('autocmd!')
    for _, au in pairs(autocmds) do
        cmd('autocmd ' .. table.concat(au, ' '))
    end
end

M.augroup({
    { 'BufWinEnter', '*', 'set formatoptions-=ro' },
    { 'FileType', 'rust', 'set colorcolumn=101' },
    { 'FileType', 'help', 'wincmd L' },
    { 'BufWritePre', '*', ':mark ` | %s:\\v\\s+$::ge | normal! ``' },
}, 'vimrc')

return M
