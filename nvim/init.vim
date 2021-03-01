"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           Givon's NeoVim Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" *****************************************************************************
" Non-Plugin Related Configuration
" *****************************************************************************

" =============================================================================
"                                  Options
" =============================================================================
set nu				        " Add line numbers
set relativenumber		    " Make line numbers relative
set colorcolumn=80	    	" Add ruler to indicate 80th column
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
set scrolloff=2             " Min 3 lines between edge of screen and cursor
set nrformats-=octal        " Stop C-A and C-X from Using Octal Numbers
set undofile                " Persistent undo history
set mouse=a                 " Mouse-clicking in insert, visual, and normal mode

" =============================================================================
"                              Global Variables
" =============================================================================
"   Pin python host to avoid duplicating nvim dependencies across venvs
let g:python3_host_prog = '/usr/bin/python'

" =============================================================================
"                              Helper Functions
" =============================================================================
"   maximize current window
function! s:win_max()
    let t:win_sizes = { 'before': winrestcmd() }
    vert resize | resize
    let t:win_sizes.after = winrestcmd()
endfunction

"   restore window size
function! s:win_restore()
    if exists('t:win_sizes')
        silent! exe t:win_sizes.before
        unlet t:win_sizes
    end
endfunction

"   toggle maximizing and restoring window size
function! s:win_toggle()
    if exists('t:win_sizes') && t:win_sizes.after == winrestcmd()
        call s:win_restore()
    elseif winnr('$') > 1
        call s:win_max()
    endif
endfunction

"   get syntax groups of character under cursor
function! s:syntax_stack()
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunction

" =============================================================================
"                                  Mappings
" =============================================================================
"   define leader key as <space>
let mapleader=' '

" -----------------------------------------------------------------------------
" Navigation
" -----------------------------------------------------------------------------

"   switch between buffers easily
nnoremap <silent> <leader>b :buffers<cr>:buffer<space>
nnoremap <silent> gb :bnext<cr>
nnoremap <silent> gB :bprev<cr>

"   navigate between splits easily in normal...
nnoremap <silent> <M-h> :wincmd h<cr>
nnoremap <silent> <M-j> :wincmd j<cr>
nnoremap <silent> <M-k> :wincmd k<cr>
nnoremap <silent> <M-l> :wincmd l<cr>
"   ...and terminal mode
tnoremap <silent> <M-h> <C-\><C-N>:wincmd h<cr>
tnoremap <silent> <M-j> <C-\><C-N>:wincmd j<cr>
tnoremap <silent> <M-k> <C-\><C-N>:wincmd k<cr>
tnoremap <silent> <M-l> <C-\><C-N>:wincmd l<cr>

"   move splits around easily in normal...
nnoremap <silent> <S-M-h> :wincmd H<cr>
nnoremap <silent> <S-M-j> :wincmd J<cr>
nnoremap <silent> <S-M-k> :wincmd K<cr>
nnoremap <silent> <S-M-L> :wincmd L<cr>
"   ...and terminal mode
tnoremap <silent> <S-M-h> <C-\><C-N>:wincmd H<cr>
tnoremap <silent> <S-M-j> <C-\><C-N>:wincmd J<cr>
tnoremap <silent> <S-M-k> <C-\><C-N>:wincmd K<cr>
tnoremap <silent> <S-M-L> <C-\><C-N>:wincmd L<cr>

"   easier horizontal scrolling
noremap zl zL
noremap zh zH

"   open new tab
nnoremap <silent> <leader>l :tabnew<cr>

"   close current window
nnoremap <silent> <leader>c :close<cr>

"   make current window the only window
nnoremap <silent> <leader>o :only<cr>

"   move whole lines up and down
"   -- normal mode
nnoremap <silent> <C-j> m`:m+1<cr>``
nnoremap <silent> <C-k> m`:m-2<cr>``
"   -- visual mode
vnoremap <silent> <C-j> :m'>+1<cr>`<my`>mzgv`yo`z
vnoremap <silent> <C-k> :m'<-2<cr>`>my`<mzgv`yo`z

"   toggle between maximized and normally sized windows in current tab
nnoremap <leader>m :call <SID>win_toggle()<cr>

" -----------------------------------------------------------------------------
" Quality of Life
" -----------------------------------------------------------------------------
"   turn of highlighting following a search
nnoremap <silent> <leader>h :nohl<cr>

"   leave insert mode via 'jj'
inoremap jj <esc>

"   exit termninal mode with jj
tnoremap jj <C-\><C-N>

"   create newlines above/below while 'virtually' staying in normal mode
nnoremap oo m`o<esc>``
nnoremap OO m`O<esc>``

"   remove trailing white space
nnoremap <silent> <leader>w m`:%s/\s\+$//e<cr>:nohl<cr>``

"   copy to system clipboard
noremap <leader>y "+y
noremap <leader>x "+x

"   paste from system clipboard
noremap <leader>p "+p

"   faster substitution
nnoremap <leader><leader> :%s:\v::g<Left><Left><Left>
nnoremap <leader>; :s:\v::g<Left><Left><Left>
nnoremap <leader>' :.,$s:\v::g<Left><Left><Left>

"   faster :g commands
nnoremap <leader>g :%g:\v

"   very-magic searching
noremap ? ?\v
noremap / /\v

"   edit this file from anywhere
nnoremap <leader>n :edit $MYVIMRC<cr>
nnoremap <leader>N :tabnew $MYVIMRC<cr>

"   source this file from anywhere
nnoremap <leader>s :source $MYVIMRC<cr>

"   toggle on and off spell checking for local buffer
nnoremap <leader>e :setlocal spell!<cr>

"   vimdiff
nnoremap <leader>dh :diffget //2
nnoremap <leader>dl :diffget //3

"   syntax highlighting debugging
nnoremap <C-S-P> :call <SID>syntax_stack()<cr>

" =============================================================================
"                               Auto-Commands
" =============================================================================
augroup mine
    " Force preferred formatoptions to take precedence
    au BufWinEnter * set formatoptions-=ro
    " Custom textwidth commands for different filetypes
    au FileType rust set colorcolumn=101
    " Always open help in a vertical split to the right
    au FileType help wincmd L
    " Restore window size when switching windows in current tab
    au WinLeave * call s:win_restore()
augroup end

" *****************************************************************************
"                      Non-Plugin Related Configuration
" *****************************************************************************

" =============================================================================
"                                Plugin Init
" =============================================================================
call plug#begin(stdpath('data') . '/plugged')

"   surround mode
Plug 'tpope/vim-surround'

"   personal wiki
Plug 'vimwiki/vimwiki', {'branch': 'dev'}

"   fancy status lines
Plug 'itchyny/lightline.vim'

"   imporved latex features
Plug 'lervag/vimtex'

"   OneDark colorscheme
Plug 'joshdick/onedark.vim'

"   improved syntax highlighting
Plug 'sheerun/vim-polyglot'

"   vscode-like autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"   fzf for quick file navigation within project directories
Plug 'junegunn/fzf.vim'

"   Change working directory to project root when in project files
Plug 'airblade/vim-rooter'

"   git integration
Plug 'tpope/vim-fugitive'

call plug#end()

" =============================================================================
"                              Helper Functions
" =============================================================================
"   Provide git info to lightline
function! g:LightlineGitStatus() abort
    return get(g:, 'coc_git_status', '') . get(b:, 'coc_git_status', '')
endfunction

"   Beautify Vimwiki headers
function! s:vimwiki_header_higlights()
    hi VimwikiHeader1   ctermbg=NONE  ctermfg=2  cterm=bold  guibg=NONE  guifg=#98c379  gui=bold
    hi VimwikiHeader2   ctermbg=NONE  ctermfg=5  cterm=bold  guibg=NONE  guifg=#c678dd  gui=bold
    hi VimwikiHeader3   ctermbg=NONE  ctermfg=4  cterm=bold  guibg=NONE  guifg=#61afef  gui=bold
    hi VimwikiHeader4   ctermbg=NONE  ctermfg=3  cterm=bold  guibg=NONE  guifg=#e5c07b  gui=bold
    hi VimwikiHeader5   ctermbg=NONE  ctermfg=6  cterm=bold  guibg=NONE  guifg=#56b6c2  gui=bold
    hi VimwikiHeader6   ctermbg=NONE  ctermfg=1  cterm=bold  guibg=NONE  guifg=#e06c75  gui=bold
endfunction

"   Redefine Vimwiki link handling behavior
function! g:VimwikiLinkHandler(link)
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

"   Show documentation for word under cursor
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" =============================================================================
"                                  Options
" =============================================================================
"   define localleader for plugins to use as <comma>
let maplocalleader=','

" -----------------------------------------------------------------------------
" onedark.vim
" -----------------------------------------------------------------------------
set termguicolors
let g:onedark_hide_endofbuffer = 1
let g:ondark_terminal_italics = 1
colorscheme onedark

" -----------------------------------------------------------------------------
" lightline.vim
" -----------------------------------------------------------------------------
let g:lightline = {
            \ 'colorscheme': 'onedark',
            \ 'component_function': {
            \   'cocstatus': 'coc#status',
            \   'gitstatus': 'LightlineGitStatus'
            \   },
            \ 'active': {
                \ 'left': [
                    \ ['mode', 'paste'],
                    \ ['readonly', 'filename', 'modified', 'gitstatus', 'cocstatus']
                \ ],
                \ 'right': [
                    \ ['lineinfo'],
                    \ ['percent'],
                    \ ['fileformat', 'fileencoding', 'filetype']
                \ ],
            \   },
            \ 'inactive': {
                \ 'left': [
                    \ ['readonly', 'filename', 'modified']
                \ ],
                \ 'right': [
                    \ ['lineinfo'],
                    \ ['percent']
                \ ],
              \ },
            \ 'tabline': {
                \ 'left': [
                    \ ['tabs']
                \ ],
                \ 'right': [
                    \ ['close']
                \ ],
            \   },
            \ 'tab' : {
                \ 'active': ['tabnum', 'filename', 'modified'],
                \ 'inactive': ['tabnum', 'filename', 'modified']
            \   },
            \ }

" -----------------------------------------------------------------------------
" vimwiki
" -----------------------------------------------------------------------------
"   Use custom wiki header highlighting
call s:vimwiki_header_higlights()

"   Self-defined paths to wiki
let g:vimwiki_list = [
            \ {
            \ 'path': '~/.local/share/wiki/',
            \ 'path_html': '~/.local/share/wiki_html/',
            \ 'template_path': '~/.local/share/wiki_html/templates/',
            \ 'template_default': 'default',
            \ 'template_ext': '.html',
            \ 'auto_toc': 1,
            \ 'toc_header': 'Table of Contents',
            \ 'auto_diary_index': 1,
            \ 'diary_caption_level': -1,
            \ 'auto_generate_links': 1,
            \ 'links_space_char': ' ',
            \ 'cycle_bullets': 1,
            \ },
            \ ]

"   Remove default table keyboard mappings to replace w/ own
let g:vimwiki_key_mappings = {
            \ 'table_mappings': 0
            \ }

"   Highlight the list item of a todo that has been checked off
let g:vimwiki_hl_cb_checked = 2

"   Default to index.wiki when only directory specified in wiki link path
let g:vimwiki_dir_link = 'index'

"   Conceal preformatted text markers
let g:vimwiki_conceal_pre = 1

"   Make <localleader> the vimwiki map prefix
let g:vimwiki_map_prefix = '<localleader>w'

"   Table of Contents Header
let g:vimwiki_toc_header = 'Table of Contents'

"   Prevent all markdown files from being treated like temporary wikis
let g:vimwiki_global_ext = 0

" -----------------------------------------------------------------------------
" vimtex
" -----------------------------------------------------------------------------
let g:vimtex_compiler_method='latexmk'
let g:vimtex_view_method='zathura'
let g:tex_flavor='latex'
let g:tex_conceal = "abdmg"
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_indent_on_ampersands = 0

" -----------------------------------------------------------------------------
" coc.nvim
" -----------------------------------------------------------------------------
"   Global Extensions
let g:coc_global_extensions =[
            \ 'coc-json',
            \ 'coc-css',
            \ 'coc-html',
            \ 'coc-markdownlint',
            \ 'coc-pyright',
            \ 'coc-sh',
            \ 'coc-pairs',
            \ 'coc-snippets',
            \ 'coc-syntax',
            \ 'coc-vimtex',
            \ 'coc-omni',
            \ 'coc-tag',
            \ 'coc-word',
            \ 'coc-yaml',
            \ 'coc-rust-analyzer',
            \ 'coc-marketplace',
            \ 'coc-vimlsp',
            \ 'coc-git',
            \ 'coc-tsserver',
            \ 'coc-prettier'
            \ ]

"   Compatability options
set hidden              " TextEdit might fail if not hidden
set nobackup            " Some servers have issues with backup files
set nowritebackup       " Some servers have issues with backup files
set cmdheight=2         " Give more screenspace for displaying messages
set updatetime=300      " Longer updatetimes result in noticeable delays
set shortmess+=c        " Don't pass messages to ins-completion-menu
set signcolumn=yes      " Always show the sign column


"  Use tab and shift-tab to select completion option
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"  Use <cr> for completion confirmation
inoremap <silent><expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" :
            \ &filetype ==# 'vimwiki' ? "<C-]><Esc>:VimwikiReturn 1 5<cr>" :
            \ "\<C-g>u\<cr>\<C-r>=coc#on_enter()\<cr>"

"  Scroll within floating windows
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

"   Navigate diagnostics
nmap <silent> <localleader>ck <Plug>(coc-diagnostic-prev)
nmap <silent> <localleader>cj <Plug>(coc-diagnostic-next)

"   GoTo code navigation.
nmap <silent> <localleader>cd <Plug>(coc-definition)
nmap <silent> <localleader>cy <Plug>(coc-type-definition)
nmap <silent> <localleader>ci <Plug>(coc-implementation)
nmap <silent> <localleader>cr <Plug>(coc-references)

"   Use K to show documentation in window
nnoremap <silent> K :call <SID>show_documentation()<cr>

"   Symbol renaming
nmap <localleader>cr <Plug>(coc-rename)

"   Formatting
nmap <localleader>cf <Plug>(coc-format)
nmap <localleader>csf  <Plug>(coc-format-selected)

"   Applying codeAction to the selected region
nmap <localleader>csa  <Plug>(coc-codeaction-selected)

"   Applying codeAction to the current buffer
nmap <localleader>ca  <Plug>(coc-codeaction)

"   Apply AutoFix to problem on the current line
nmap <localleader>cc  <Plug>(coc-fix-current)

"   Function and Class text objects
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
omap ic <Plug>(coc-classobj-i)
omap ac <Plug>(coc-classobj-a)

"   Organize imports
nnoremap <localleader>co :call CocAction('runCommand', 'editor.action.organizeImport')<cr>

"   Show all diagnostics
nnoremap <silent><nowait> <localleader>cld  :<C-u>CocList diagnostics<cr>

"   Manage extensions
nnoremap <silent><nowait> <localleader>cle  :<C-u>CocList extensions<cr>

"   Show CoC commands
nnoremap <silent><nowait> <localleader>clm  :<C-u>CocList commands<cr>

"   Explore symbols in current document
nnoremap <silent><nowait> <localleader>clo  :<C-u>CocList outline<cr>

"   Search workspace symbols
nnoremap <silent><nowait> <localleader>cls  :<C-u>CocList -I symbols<cr>

"   Do default action for next item
nnoremap <silent><nowait> <localleader>cj  :<C-u>CocNext<cr>

"   Do default action for previous item
nnoremap <silent><nowait> <localleader>ck  :<C-u>CocPrev<cr>

"   Resume latest coc list
nnoremap <silent><nowait> <localleader>clr  :<C-u>CocListResume<cr>

"   Snippet editing
nnoremap <silent> <localleader>ces :CocCommand snippets.editSnippets<cr>
nnoremap <silent> <localleader>cos :CocCommand snippets.openSnippetFiles<cr>

"   Expand, select, and jump with snippets
let g:coc_snippet_next = ';j'
let g:coc_snippet_prev = ';k'

"   navigate git chunks of current buffer
nmap <localleader>cgk <Plug>(coc-git-prevchunk)
nmap <localleader>cgj <Plug>(coc-git-nextchunk)
nmap <localleader>cgs <Plug>(coc-git-chunkinfo)

" -----------------------------------------------------------------------------
" fzf.vim
" -----------------------------------------------------------------------------
"   Easily accessible mappings
nnoremap <silent> <localleader>ff :Files<cr>
nnoremap <silent> <localleader>fg :GFiles<cr>
nnoremap <silent> <localleader>fr :Rg<cr>
nnoremap <silent> <localleader>fb :Buffers<cr>

" -----------------------------------------------------------------------------
" vim-rooter
" -----------------------------------------------------------------------------
"   Specify root project directory contains .git directory
let g:rooter_patterns = ['.git']

" =============================================================================
"                               Auto-Commands
" =============================================================================
"   Vimwiki remaps
augroup vimwiki_prefs
    au!
    au FileType vimwiki nnoremap <silent><buffer> gls :VimwikiChangeSymbolTo *<cr>
    au FileType vimwiki nnoremap <silent><buffer> gld :VimwikiChangeSymbolTo -<cr>
    au FileType vimwiki nnoremap <silent><buffer> glt :VimwikiChangeSymbolTo #<cr>
    au FileType vimwiki nnoremap <silent><buffer> glm :VimwikiChangeSymbolTo 1.<cr>
    au FileType vimwiki inoremap <silent><expr><buffer> <A-t> vimwiki#tbl#kbd_tab()
    au FileType vimwiki inoremap <silent><expr><buffer> <A-T> vimwiki#tbl#kbd_shift_tab()
    au FileType vimwiki nnoremap <buffer> <localleader>t :VimwikiTable<space>
    au FileType vimwiki inoremap <silent><buffer> <A-CR> <C-]><Esc>:VimwikiReturn 2 2<cr>
    au FileType vimwiki nnoremap <silent><buffer> <localleader><leader> :VimwikiToggleListItem<cr
augroup end
