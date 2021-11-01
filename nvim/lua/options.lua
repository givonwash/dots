local opt = vim.opt

--[[========================== option parameters ============================]]
local INDENT_LEN = 4

--[[=============================== options =================================]]

opt.number = true -- line numbers
opt.relativenumber = true -- relative line numbers
opt.colorcolumn = { '+1' } -- ruler for textwidth
opt.cursorline = true -- highlight screen line
opt.signcolumn = 'yes' -- always show signcolumn
opt.wrap = false -- no line wrapping
opt.expandtab = true -- tabs --> spaces
opt.smartindent = true -- indent new line where appropriate
opt.autoindent = true -- reuse indent from current line
opt.shiftwidth = INDENT_LEN -- # of spaces for (auto)?indent
opt.tabstop = INDENT_LEN -- # of spaces <tab> counts for
opt.softtabstop = INDENT_LEN -- # of spaces <tab> counts for when editing
opt.undofile = true -- persistent undo history
opt.timeoutlen = 300 -- 300ms timeout for keymaps
opt.splitright = true -- open splits on right
opt.splitbelow = true -- open splits on bottom
opt.hidden = true -- keep buffers loaded when abandoned
opt.ignorecase = true -- ignorecase when searching
opt.smartcase = true -- infer if search should be case-sensitive
opt.smarttab = true -- smart tab behavior
opt.incsearch = true -- goto word as it is being searched
opt.scrolloff = 2 -- buffer between screen edge and cursor
opt.history = 500 -- command history max size
opt.lazyredraw = true -- no redrawing of screen during macros
opt.showmode = false -- no '-- INSERT --' above command-line
opt.termguicolors = true -- enable 24-bit rgb
opt.conceallevel = 2 -- make pmenu docs look pretty
