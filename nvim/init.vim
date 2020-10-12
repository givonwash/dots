" =============================================================================
"   Givon's Basic NeoVim Config
"   NOTE: config is basic as its meant to be forked for different machines
" =============================================================================

" -----------------------------------------------------------------------------
"   Configuring Options
" -----------------------------------------------------------------------------
set nu				        " Add line numbers
set relativenumber		    " Make line numbers relative
set colorcolumn=81	    	" Add ruler to indicate 81st column
set nowrap		        	" No line wrapping
set timeoutlen=300	    	" Eliminate wait time for key-sharing commands
set splitright		    	" Always split vertically split windows right
set splitbelow		    	" Always split horizontally split windows below
set hidden		        	" When a buffer is abandoned it remains loaded
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
"   Basic Mappings
" -----------------------------------------------------------------------------
"   define leader key as <space>
let mapleader=' '
let maplocalleader=','

"   turn of highlighting following a search
noremap <silent> <leader>h :nohl<cr>

"   leave insert mode via 'jj'
inoremap jj <esc>

"   create newlines above/below while 'virtually' staying in normal mode
nnoremap oo m`o<esc>``
nnoremap OO m`O<esc>``

"   switch between buffers easily
nmap <leader>b :buffers<cr>:buffer<space>
nnoremap gb :bnext<cr>
nnoremap gB :bprev<cr>

"   remove trailing white space
nmap <leader>t :%s/\s\+$//e<cr>

"   copy to system clipboard
nnoremap <leader>y "+y

"   paste from system clipboard
nnoremap <leader>p "+p

"   exit termninal mode with jj
tnoremap jj <C-\><C-N>

"   faster whole file substitution
nnoremap <leader><leader> :%s:::g<Left><Left><Left>
nnoremap <leader>' :%s:::gc<Left><Left><Left><Left>

"   edit this file from anywhere
nnoremap <leader>n :edit $MYVIMRC<cr>
nnoremap <leader>N :vsplit $MYVIMRC<cr>
nnoremap <leader>t :tabnew $MYVIMRC<cr>

"   source this file from anywhere
nnoremap <leader>s :source $MYVIMRC<cr>

"   close current window/tab
nnoremap <silent> <leader>cc :close<cr>
nnoremap <silent> <leader>nn :tabnew<cr>

"   define some general useful operator pending mappings
onoremap p i(
onoremap ' i'
onoremap " i"
onoremap [ i[
onoremap { i{

" -----------------------------------------------------------------------------
"   Custom Commands
" -----------------------------------------------------------------------------
command! -nargs=* -complete=help Help vertical belowright help <args>

augroup fmt
    au!
    au BufEnter * set formatoptions-=ro
augroup end
