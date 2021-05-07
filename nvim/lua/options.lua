local setter = require('utils').create_setter

-- setters
local wset = setter('w')
local bset = setter('b')
local gset = setter('o')

--[[========================== option parameters ============================]]
local INDENT_LEN = 4

--[[=============================== options =================================]]

wset('number', true)                    -- line numbers
wset('relativenumber', true)            -- relative line numbers
wset('colorcolumn', '80')               -- ruler for textwidth
wset('cursorline', true)                -- highlight screen line
wset('signcolumn', 'yes')               -- always show signcolumn
wset('wrap', false)                     -- no line wrapping
bset('expandtab', true)                 -- tabs --> spaces
bset('smartindent', true)               -- indent new line where appropriate
bset('autoindent', true)                -- reuse indent from current line
bset('shiftwidth', INDENT_LEN)          -- # of spaces for (auto)?indent
bset('tabstop', INDENT_LEN)             -- # of spaces <tab> counts for
bset('softtabstop', INDENT_LEN)         -- # of spaces <tab> counts for when editing
bset('undofile', true)                  -- persistent undo history
gset('timeoutlen', 300)                 -- 300ms timeout for keymaps
gset('splitright', true)                -- open splits on right
gset('splitbelow', true)                -- open splits on bottom
gset('hidden', true)                    -- keep buffers loaded when abandoned
gset('ignorecase', true)                -- ignorecase when searching
gset('smartcase', true)                 -- infer if search should be case-sensitive
gset('smarttab', true)                  -- smart tab behavior
gset('incsearch', true)                 -- goto word as it is being searched
gset('scrolloff', 2)                    -- buffer between screen edge and cursor
gset('history', 500)                    -- command history max size
gset('lazyredraw', true)                -- no redrawing of screen during macros
gset('showmode', false)                 -- no '-- INSERT --' above command-line
gset('termguicolors', true)             -- enable 24-bit rgb

return {
    wset = wset,
    bset = bset,
    gset = gset,
}
