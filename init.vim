" =============================================================================
" Givon's NeoVim Config
" =============================================================================
"
" -----------------------------------------------------------------------------
"  Built-in Features
" -----------------------------------------------------------------------------
set nu				        " Add line numbers
set relativenumber		    " Make line numbers relative
set colorcolumn=81	    	" Add ruler to indicate 81st column
set nowrap		        	" No line wrapping (it's hideous)
set timeoutlen=300	    	" Eliminate wait time for key-sharing commands
set splitright		    	" Always split vertically split windows right
set splitbelow		    	" Always split horizontally split windows below
set hidden		        	" When a buffer is abandoned it remains loaded
set termguicolors		    " Enable 24-bit RGB color
set ignorecase		    	" Ignore case by default when searching
set smartcase		    	" Infer whether I want a case-sensitive search
set incsearch		    	" Go-to word as it being typed in search
set tabstop=4		    	" Make tabs 4 spaces
set expandtab		    	" Convert tabs to spaces
set shiftwidth=4	    	" Make indents 4 spaces
set softtabstop=4	    	" Backspace will remove tabs instead of spaces
set smarttab		     	" Tabbing in front of a line inserts 4 spaces
set smartindent		    	" Smartindent on a newline
set autoindent		    	" Copy indent from current line for newlines

" -----------------------------------------------------------------------------
"  Basic Mappings
" -----------------------------------------------------------------------------
"  define leader key as <space>
let mapleader=' '

"  turn of highlighting following a search
map <silent> <leader>h :nohl<cr>

"  toggle automatic comment formatting for newlines
map <leader>c :setlocal formatoptions-=cro<cr>
map <leader>C :setlocal formatoptions+=cro<cr>

"  leave insert mode via 'jj'
inoremap jj <esc>

"  create newlines above/below while 'virtually' staying in normal mode
nnoremap oo m`o<esc>``
nnoremap OO m`O<esc>``

"  switch between buffers easily
nmap <leader>b :buffers<cr>:buffer<space>

"  remove trailing white space
nmap <leader>tr :%s/\s\+$//e<cr>

"  paste from system clipboard
nmap <leader>p "+p
