local api = vim.api

local mapper = function(mode, defaults, is_buf_local)
    local defaults = defaults or { noremap = true, silent = true }
    if not is_buf_local then
        return function(lhs, rhs, opts)
            local opts = opts or {}
            local options = vim.tbl_extend('force', defaults, opts)
            api.nvim_set_keymap(mode, lhs, rhs, options)
        end
    else
        return function(lhs, rhs, opts)
            local opts = opts or {}
            local options = vim.tbl_extend('force', defaults, opts)
            api.nvim_buf_set_keymap(0, mode, lhs, rhs, options)
        end
    end
end

local map_opts = {
    no_silent = { silent = false },
    recursive = { noremap = false },
    expr = { expr = true },
}

local map = mapper('')
local imap = mapper('i')
local nmap = mapper('n')
local tmap = mapper('t')
local vmap = mapper('v')

local no_silent = map_opts.no_silent

--[[=============================== mappings ================================]]

--                               [[navigation]]
-- navigate regular splits
nmap('˙', '<cmd>wincmd h<cr>')
nmap('∆', '<cmd>wincmd j<cr>')
nmap('˚', '<cmd>wincmd k<cr>')
nmap('¬', '<cmd>wincmd l<cr>')

-- move regular splits around
nmap('Ó', '<cmd>wincmd H<cr>')
nmap('Ô', '<cmd>wincmd J<cr>')
nmap('', '<cmd>wincmd K<cr>')
nmap('Ò', '<cmd>wincmd L<cr>')

-- navigate termninal splits
tmap('˙', '<C-\\><C-N><cmd>wincmd h<cr>')
tmap('∆', '<C-\\><C-N><cmd>wincmd j<cr>')
tmap('˚', '<C-\\><C-N><cmd>wincmd k<cr>')
tmap('¬', '<C-\\><C-N><cmd>wincmd l<cr>')

-- move terminal splits around
tmap('Ó', '<C-\\><C-N><cmd>wincmd H<cr>')
tmap('Ô', '<C-\\><C-N><cmd>wincmd J<cr>')
tmap('', '<C-\\><C-N><cmd>wincmd K<cr>')
tmap('Ò', '<C-\\><C-N><cmd>wincmd L<cr>')

-- horizontal scrolling
map('zl', 'zL')
map('zh', 'zH')

-- make current window the only window
nmap('<leader>o', '<cmd>only<cr>')

-- close windows
nmap('<leader>c', '<cmd>close<cr>')

-- move thru quickfix list
nmap('<C-n>', '<cmd>cnext<cr>')
nmap('<C-p>', '<cmd>cprev<cr>')

-- move thru location list
nmap('<M-n>', '<cmd>lnext<cr>')
nmap('<M-p>', '<cmd>lprev<cr>')

--                            [[quality of life]]
-- toggle highlighting following a search
nmap('<leader>h', '<cmd>nohlsearch<cr>')

-- leave insert mode
imap('jj', '<esc>')

-- leave terminal mode
tmap('jj', '<C-\\><C-N>')

-- create new lines above/below
nmap('oo', 'm`o<esc>``')
nmap('OO', 'm`O<esc>``')

-- copy to system clipboard
map('<leader>y', '"+y', no_silent)

-- paste from system clipboard
nmap('<leader>p', '"+p', no_silent)

-- fast substitution
nmap('<leader><leader>', ':%s:\\v::g<left><left><left>', no_silent)
nmap('<leader>;', ':s:\\v::g<left><left><left>', no_silent)
nmap('<leader>\'', ':.,$s:\\v::g<left><left><left>', no_silent)
nmap('<leader>k', ':%s:\\v<<C-r><C-w>>::g<left><left>', no_silent)

-- fast number incrementing/decrementing
nmap('<leader>a', ':s:\\v\\d+:\\=submatch(0) + 1:ge<cr>', no_silent)
nmap('<leader>x', ':s:\\v\\d+:\\=submatch(0) - 1:ge<cr>', no_silent)

-- fast :g commands
nmap('<leader>g', ':%g:\\v', no_silent)

-- very-magic searching
map('?', '?\\v', no_silent)
map('/', '/\\v', no_silent)

-- toggle spell checking
nmap('<leader>s', '<cmd>setlocal spell!<cr>')

return {
    mapper = mapper,
    map = map,
    imap = imap,
    nmap = nmap,
    tmap = tmap,
    vmap = vmap,
    map_opts = map_opts,
}
