" =============================================================================
"   Givon's NeoVim Config
" =============================================================================

" -----------------------------------------------------------------------------
"   Basic Options
" -----------------------------------------------------------------------------
set nu				        " Add line numbers
set relativenumber		    " Make line numbers relative
set colorcolumn=80	    	" Add ruler to indicate 80th column
set nowrap		        	" No line wrapping (it's hideous)
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
"   Non-Plugin Related Global Variables
" -----------------------------------------------------------------------------
"   To use packages from current env, use miniconda instead of system python
let g:python3_host_prog = '/home/givon/miniconda3/bin/python'

"   Remove concealing of greek letters mathematical symbols, and greek letters
let g:tex_conceal = "abd"

" -----------------------------------------------------------------------------
"   Basic Mappings
" -----------------------------------------------------------------------------
"   define leader key as <space>
let mapleader=' '

"   define localleader for plugins to use as <comma>
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

"   navigate windows easily in normal...
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
"   ...and terminal mode
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l

"   remove trailing white space
nmap <leader>w :%s/\s\+$//e<cr>

"   copy to system clipboard
noremap <leader>y "+y
noremap <leader>x "+x

"   paste from system clipboard
noremap <leader>p "+p

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

"   open new tab
nnoremap <silent> <leader>l :tabnew<cr>

"   close current window
nnoremap <silent> <leader>c :close<cr>

"   some useful operator dependent mappings
onoremap p i)
onoremap ' i'
onoremap " i"
onoremap } i}
onoremap ] i]
onoremap > i>

" -----------------------------------------------------------------------------
"   Custom Commands
" -----------------------------------------------------------------------------
command! -nargs=* -complete=help Help vertical belowright help <args>

augroup fmt
    au!
    au BufEnter * set formatoptions-=ro
augroup end

" -----------------------------------------------------------------------------
"   Plugins (handled via the Vim-Plug plugin manager)
" -----------------------------------------------------------------------------
call plug#begin(stdpath('data') . '/plugged')

"   colorscheme
Plug 'dylanaraps/wal.vim'

"   surround mode
Plug 'tpope/vim-surround'

"   personal wiki
Plug 'vimwiki/vimwiki', {'branch': 'dev'}

"   fancy status lines
Plug 'itchyny/lightline.vim'

"   better latex doc handling
Plug 'lervag/vimtex'

"   vscode-like autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" -----------------------------------------------------------------------------
"  Plugin Compatability
" -----------------------------------------------------------------------------
"   --  python-pywal vim colorscheme
colorscheme wal

"   -- lightline.vim
let g:lightline = {
            \ 'colorscheme': 'wal',
            \ 'component_function': {
            \   'cocstatus': 'coc#status'
            \   },
            \ 'active': {
                \ 'left': [
                    \ ['mode', 'paste'],
                    \ ['readonly', 'filename', 'modified', 'cocstatus']
                \ ]
            \   }
            \ }

"   -- vim-wiki
"   ---- Redefine Link Handling Behavior
function! VimwikiLinkHandler(link)
    " Use nvim to open external files with the nfile: prefix
    " >>> [[nfile:~/.config/nvim/init.vim]]
    let link = a:link
    if link =~# '^nfile:'
        let link = link[1:]
    else
        return 0
    endif
    let link_infos = vimwiki#base#resolve_link(link)
    if link_infos.filename == ''
        echomsg 'Vimwiki Error: Unable to resolve link!'
        return 0
    else
        exe 'tabnew ' . fnameescape(link_infos.filename)
        return 1
    endif
endfunction

" ---- Compatability options
set nocompatible
filetype plugin on

" ---- Self-defined paths to wiki
let g:vimwiki_list = [
            \ {
            \ 'path': '~/.local/share/wiki/',
            \ 'auto_toc': 1,
            \ 'auto_diary_index': 1,
            \ 'auto_generate_links': 1,
            \ 'links_space_char': ' ',
            \ },
            \ ]

" ---- Remove default table keyboard mappings to replace w/ own
let g:vimwiki_key_mappings = {
            \ 'table_mappings': 0
            \ }

" ---- Highlight the list item of a todo that has been checked off
let g:vimwiki_hl_cb_checked = 2

" ---- Default to index.wiki when only directory specified in wiki link path
let g:vimwiki_dir_link = 'index'

" ---- Conceal preformatted text markers
let g:vimwiki_conceal_pre = 1

" ---- Make <localleader> the vimwiki map prefix
let g:vimwiki_map_prefix = '<localleader>w'

" ---- Table of Contents Header
let g:vimwiki_toc_header = 'Table of Contents'

" ---- Remap vimwiki keybindings when opening files of filetype vimwiki
augroup vimwiki_prefs
    au!
    au FileType vimwiki
                \ nnoremap <silent><buffer> gls :VimwikiChangeSymbolTo *<CR>|
                \ nnoremap <silent><buffer> gld :VimwikiChangeSymbolTo -<CR>|
                \ nnoremap <silent><buffer> glt :VimwikiChangeSymbolTo #<CR>|
                \ nnoremap <silent><buffer> glm :VimwikiChangeSymbolTo 1.<CR>|
                \ inoremap <silent><expr><buffer> <A-t> vimwiki#tbl#kbd_tab()|
                \ inoremap <silent><expr><buffer> <A-T> vimwiki#tbl#kbd_shift_tab()|
                \ nmap <localleader>t :VimwikiTable<space>|
                \ inoremap <silent><buffer> <A-CR> <C-]><Esc>:VimwikiReturn 2 2<CR>|
augroup end

" ---- Define custom colors and font faces for vimwiki headers
hi VimwikiHeader1 guifg='LightYellow'   gui=bold,underline  ctermfg=14  cterm=bold,underline
hi VimwikiHeader2 guifg='LightBlue'     gui=bold,underline  ctermfg=9   cterm=bold,underline
hi VimwikiHeader3 guifg='LightGreen'    gui=bold,underline  ctermfg=10  cterm=bold,underline
hi VimwikiHeader4 guifg='LightCyan'     gui=bold,underline  ctermfg=11  cterm=bold,underline
hi VimwikiHeader5 guifg='LightRed'      gui=bold,underline  ctermfg=12  cterm=bold,underline
hi VimwikiHeader6 guifg='LightMagenta'  gui=bold,underline  ctermfg=13  cterm=bold,underline

"   -- vimtex
let g:vimtex_compiler_method='latexmk'
let g:vimtex_view_method='zathura'
let g:tex_flavor='latex'
let g:vimtex_compiler_progname = 'nvr'

"   -- coc.nvim
let g:coc_global_extensions =[
            \ 'coc-json',
            \ 'coc-css',
            \ 'coc-markdownlint',
            \ 'coc-python',
            \ 'coc-sh',
            \ 'coc-pairs',
            \ 'coc-snippets',
            \ 'coc-syntax',
            \ 'coc-vimtex',
            \ 'coc-omni',
            \ 'coc-tag',
            \ 'coc-word',
            \ 'coc-yaml'
            \ ]

"   ---- Compatability Options
set hidden              " TextEdit might fail if not hidden
set nobackup            " Some servers have issues with backup files
set nowritebackup       " Some servers have issues with backup files
set cmdheight=2         " Give more screenspace for displaying messages
set updatetime=300      " Longer updatetimes result in noticeable delays
set shortmess+=c        " Don't pass messages to ins-completion-menu
set signcolumn=yes      " Always show the sign column

"   ---- Helper Functions
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"   ---- Use tab and shift-tab to select completion option
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"   ---- Use <CR> for completion confirmation
inoremap <silent><expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" :
            \ &filetype ==# 'vimwiki' ? "<C-]><Esc>:VimwikiReturn 1 5<CR>" :
            \ "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

"   ---- Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"   ---- GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"   ---- Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

"   ---- Symbol renaming.
nmap <localleader>rn <Plug>(coc-rename)

"   ---- Formatting selected code.
xmap <localleader>f  <Plug>(coc-format-selected)
nmap <localleader>f  <Plug>(coc-format-selected)

"   ---- Applying codeAction to the selected region.
xmap <localleader>a  <Plug>(coc-codeaction-selected)
nmap <localleader>a  <Plug>(coc-codeaction-selected)

"   ---- Remap keys for applying codeAction to the current buffer.
nmap <localleader>ac  <Plug>(coc-codeaction)

"   ---- Apply AutoFix to problem on the current line.
nmap <localleader>qf  <Plug>(coc-fix-current)

"   ---- Map function and class text objects
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

"   ---- Use CTRL-S for selections ranges.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

"   ---- Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

"   ---- Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

"   ---- Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call CocAction('runCommand', 'editor.action.organizeImport')

"   ---- Mappings for CoCList
"   ------ Show all diagnostics.
nnoremap <silent><nowait> <localleader>d  :<C-u>CocList diagnostics<cr>

"   ------ Manage extensions.
nnoremap <silent><nowait> <localleader>e  :<C-u>CocList extensions<cr>

"   ------ Show commands.
nnoremap <silent><nowait> <localleader>m  :<C-u>CocList commands<cr>

"   ------ Find symbol of current document.
nnoremap <silent><nowait> <localleader>o  :<C-u>CocList outline<cr>

"   ------ Search workspace symbols.
nnoremap <silent><nowait> <localleader>s  :<C-u>CocList -I symbols<cr>

"   ------ Do default action for next item.
nnoremap <silent><nowait> <localleader>j  :<C-u>CocNext<CR>

"   ------ Do default action for previous item.
nnoremap <silent><nowait> <localleader>k  :<C-u>CocPrev<CR>

"   ------ Resume latest coc list.
nnoremap <silent><nowait> <localleader>r  :<C-u>CocListResume<CR>

"   ---- Extension Specific Mappings
"   ------ coc-snippets
"   -------- snippet editing
nnoremap <silent> <localleader><leader>s :CocCommand snippets.editSnippets<CR>
nnoremap <silent> <localleader><leader>o :CocCommand snippets.openSnippetFiles<CR>

"   -------- expand, select, and jump with snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = ';j'
let g:coc_snippet_prev = ';k'
