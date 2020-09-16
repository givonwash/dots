" =============================================================================
"   Givon's NeoVim Config
" =============================================================================

" -----------------------------------------------------------------------------
"   Configuring Options
" -----------------------------------------------------------------------------
set nu				        " Add line numbers
set relativenumber		    " Make line numbers relative
set colorcolumn=81	    	" Add ruler to indicate 81st column
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
let g:python3_host_prog = '/home/givonwash/miniconda3/bin/python'

" -----------------------------------------------------------------------------
"   Basic Mappings
" -----------------------------------------------------------------------------
"   define leader key as <space>
let mapleader=' '

"   turn of highlighting following a search
map <silent> <leader>h :nohl<cr>

"   toggle automatic comment formatting for newlines
map <silent> <leader>c :setlocal formatoptions-=cro<cr>
map <silent> <leader>C :setlocal formatoptions+=cro<cr>

"   leave insert mode via 'jj'
inoremap jj <esc>

"   create newlines above/below while 'virtually' staying in normal mode
nnoremap oo m`o<esc>``
nnoremap OO m`O<esc>``

"   switch between buffers easily
nmap <leader>b :buffers<cr>:buffer<space>

"   remove trailing white space
nmap <leader>tr :%s/\s\+$//e<cr>

"   copy to system clipboard
nnoremap <leader>y "+y<cr>

"   paste from system clipboard
nnoremap <leader>p "+p<cr>

" -----------------------------------------------------------------------------
"   Plugins (handled via the Vim-Plug plugin manager)
" -----------------------------------------------------------------------------
call plug#begin(stdpath('data') . '/plugged')

"   set colorscheme to colors from pywal
Plug 'dylanaraps/wal.vim'

"   surround mode
Plug 'tpope/vim-surround'

"   personal wiki
Plug 'vimwiki/vimwiki'

"   fancy status lines
Plug 'itchyny/lightline.vim'

"   vscode-like autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" -----------------------------------------------------------------------------
"  Plugin Compatability
" -----------------------------------------------------------------------------
"  --  wal.vim
colorscheme wal

"  -- lightline.vim
let g:lightline = {
            \ 'colorscheme': 'wal',
            \ 'component_function': {
            \   'cocstatus': 'coc#status'
            \   },
            \ }

"  -- vim-wiki
set nocompatible
filetype plugin on
let g:vimwiki_list = [
            \ { 
            \ 'path': '~/.local/share/wiki/',
            \ },
            \ ]

hi VimwikiHeader1 guifg='LightYellow' gui=bold,underline ctermfg=14 cterm=bold,underline
hi VimwikiHeader2 guifg='LightBlue' gui=bold,underline ctermfg=9 cterm=bold,underline
hi VimwikiHeader3 guifg='LightGreen' gui=bold,underline ctermfg=10 cterm=bold,underline
hi VimwikiHeader4 guifg='LightCyan' gui=bold,underline ctermfg=11 cterm=bold,underline
hi VimwikiHeader5 guifg='LightRed' gui=bold,underline ctermfg=12 cterm=bold,underline
hi VimwikiHeader6 guifg='LightMagenta' gui=bold,underline ctermfg=13 cterm=bold,underline

"   -- coc.nvim
"  ****************************************************************************
"   --- boiler plate config copied form https://github.com/neoclide/coc.nvim
"  ****************************************************************************
set hidden              " TextEdit might fail if not hidden
set nobackup            " Some servers have issues with backup files
set nowritebackup       " Some servers have issues with backup files
set cmdheight=2         " Give more screenspace for displaying messages
set updatetime=300      " Longer updatetimes result in noticeable delays
set shortmess+=c        " Don't pass messages to ins-completion-menu
set signcolumn=yes      " Always show the sign column

"  Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"  Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"  Use <cr> to confirm completion, `<C-g>u` means break undo chain at 
"  current position. Coc only does snippet and additional edit on confirm.
"  <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>d  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>m  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <leader>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>r  :<C-u>CocListResume<CR>

"  ****************************************************************************
"   --- end of boiler plate code
"  ****************************************************************************
