local fn = vim.fn
local utils = require 'utils'

local my_globals = _G.my_globals

my_globals.tab_complete = function ()
    if fn.pumvisible() ~= 0 then
        return utils.str_to_term_code '<C-n>'
    else
        return utils.str_to_term_code '<TAB>'
    end
end

my_globals.shift_tab_complete = function()
    if fn.pumvisible() ~= 0 then
        return utils.str_to_term_code '<C-p>'
    else
        return utils.str_to_term_code '<S-TAB>'
    end
end

-- global mappers
local mapper = utils.create_mapper
local map = mapper('')
local imap = mapper('i')
local nmap = mapper('n')
local tmap = mapper('t')
local vmap = mapper('v')

-- common mapping options
local no_silent = utils.map_opts.no_silent
local expr = utils.map_opts.expr

--[[=============================== mappings ================================]]

--                               [[navigation]]
-- switch between buffers easily
nmap('gb', '<cmd>bnext<cr>')
nmap('gB', '<cmd>bprev<cr>')

-- navigate regular splits
nmap('<M-h>', '<cmd>wincmd h<cr>')
nmap('<M-j>', '<cmd>wincmd j<cr>')
nmap('<M-k>', '<cmd>wincmd k<cr>')
nmap('<M-l>', '<cmd>wincmd l<cr>')

-- move regular splits around
nmap('<S-M-h>', '<cmd>wincmd H<cr>')
nmap('<S-M-j>', '<cmd>wincmd J<cr>')
nmap('<S-M-k>', '<cmd>wincmd K<cr>')
nmap('<S-M-l>', '<cmd>wincmd L<cr>')

-- navigate termninal splits
tmap('<M-h>', '<C-\\><C-N><cmd>wincmd h<cr>')
tmap('<M-j>', '<C-\\><C-N><cmd>wincmd j<cr>')
tmap('<M-k>', '<C-\\><C-N><cmd>wincmd k<cr>')
tmap('<M-l>', '<C-\\><C-N><cmd>wincmd l<cr>')

-- move terminal splits around
tmap('<S-M-h>', '<C-\\><C-N><cmd>wincmd H<cr>')
tmap('<S-M-j>', '<C-\\><C-N><cmd>wincmd J<cr>')
tmap('<S-M-k>', '<C-\\><C-N><cmd>wincmd K<cr>')
tmap('<S-M-l>', '<C-\\><C-N><cmd>wincmd L<cr>')

-- horizontal scrolling
map('zl', 'zL')
map('zh', 'zH')

-- make current window the only window
nmap('<leader>o', '<cmd>only<cr>')

-- close windows
nmap('<leader>c', '<cmd>close<cr>')

-- move lines up and down
nmap('<C-j>', 'm`<cmd>m+1<cr>``')
nmap('<C-k>', 'm`<cmd>m-2<cr>``')
vmap('<C-j>', [[<cmd>m'>+1<cr>`<my`>mzgv`yo`z]])
vmap('<C-k>', [[<cmd>m'<-2<cr>`>my`<mzgv`yo`z]])

-- open new tab
nmap('<leader>n', '<cmd>tabnew<cr>')

-- move thru quickfix list
nmap('<C-n>', '<cmd>cnext<cr>')
nmap('<C-p>', '<cmd>cprev<cr>')

-- move thru location list
nmap('<M-n>', '<cmd>lnext<cr>')
nmap('<M-p>', '<cmd>lprev<cr>')

-- goto definition
nmap('gd', '<cmd>lua vim.lsp.buf.definition()<cr>')

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

-- tab completion
imap('<TAB>', 'v:lua.my_globals.tab_complete()', expr)
imap('<S-TAB>', 'v:lua.my_globals.shift_tab_complete()', expr)

-- format buffer
nmap('<leader>f', '<cmd>Format<cr>')

return {
    map = map,
    imap = imap,
    nmap = nmap,
    tmap = tmap,
    vmap = vmap,
}
