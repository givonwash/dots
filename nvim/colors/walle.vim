" walle.vim -- A pywal Neovim color scheme

hi clear
set background=dark

if exists("syntax_on")
    syntax reset
endif

" Colorscheme Name
let g:colors_name="walle"

" Default Highlight Groups
"  Group            cterm-bg        cterm-fg        cterm-attr                  gui-bg              gui-fg              gui-attr
hi Normal		    ctermbg=0	    ctermfg=15		cterm=NONE                  guibg=g:color0		guifg=g:color15		gui=NONE
    hi link Conceal     Normal
    hi link NormalNC    Normal
    hi link Question    Normal
hi ColorColumn		ctermbg=4		ctermfg=NONE	cterm=NONE                  guibg=g:color4		guifg=NONE          gui=NONE
hi Cursor		    ctermbg=8	    ctermfg=NONE	cterm=NONE                  guibg=g:color8		guifg=NONE          gui=NONE
hi CursorColumn		ctermbg=3		ctermfg=NONE	cterm=NONE                  guibg=g:color3		guifg=NONE          gui=NONE
    hi link CursorLine  CursorColumn
hi Directory		ctermbg=NONE	ctermfg=12	    cterm=NONE                  guibg=NONE          guifg=g:color12		gui=NONE
hi DiffAdd		    ctermbg=NONE	ctermfg=10		cterm=NONE                  guibg=NONE          guifg=g:color10		gui=NONE
hi DiffChange		ctermbg=NONE	ctermfg=9		cterm=NONE                  guibg=NONE          guifg=g:color9		gui=NONE
hi DiffDelete		ctermbg=NONE	ctermfg=12		cterm=NONE                  guibg=NONE          guifg=g:color12		gui=NONE
hi DiffText		    ctermbg=NONE	ctermfg=10		cterm=NONE                  guibg=NONE          guifg=g:color10		gui=NONE
hi EndOfBuffer		ctermbg=NONE	ctermfg=NONE	cterm=NONE                  guibg=NONE		    guifg=NONE		    gui=NONE
hi TermCursor		ctermbg=8		ctermfg=15		cterm=NONE                  guibg=g:color8		guifg=g:color15		gui=NONE
hi TermCursorNC		ctermbg=1		ctermfg=8		cterm=NONE                  guibg=g:color1		guifg=g:color8		gui=NONE
hi ErrorMsg		    ctermbg=NONE	ctermfg=12		cterm=bold                  guibg=NONE          guifg=g:color12		gui=bold
    hi link QuickFixLine    ErrorMsg
hi WarningMsg       ctermbg=NONE    ctermfg=11      cterm=bold                  guibg=NONE          guifg=g:color11     gui=bold
hi VertSplit		ctermbg=NONE	ctermfg=9	    cterm=NONE                  guibg=NONE          guifg=g:color9		gui=NONE
hi Folded		    ctermbg=6		ctermfg=NONE	cterm=bold                  guibg=g:color6		guifg=NONE		    gui=bold
hi FoldColumn		ctermbg=NONE	ctermfg=14		cterm=NONE                  guibg=NONE          guifg=g:color14		gui=NONE
hi SignColumn		ctermbg=NONE	ctermfg=12		cterm=NONE                  guibg=NONE          guifg=g:color12		gui=NONE
hi Search		    ctermbg=NONE	ctermfg=NONE	cterm=bold,inverse          guibg=NONE		    guifg=NONE		    gui=bold,inverse
    hi link IncSearch   Search
hi Substitute		ctermbg=NONE	ctermfg=NONE	cterm=bold,italic,inverse	guibg=NONE          guifg=NONE		    gui=bold,italic,inverse
hi LineNr		    ctermbg=NONE	ctermfg=11		cterm=bold		            guibg=NONE          guifg=g:color11		gui=bold
hi CursorLineNr		ctermbg=NONE	ctermfg=15		cterm=bold                  guibg=NONE          guifg=g:color15		gui=bold
hi MatchParen		ctermbg=4	    ctermfg=8		cterm=bold                  guibg=g:color4     guifg=g:color8		gui=bold
hi ModeMsg		    ctermbg=NONE	ctermfg=NONE	cterm=bold                  guibg=NONE          guifg=NONE		    gui=bold
hi MsgArea		    ctermbg=NONE	ctermfg=15		cterm=NONE                  guibg=NONE          guifg=g:color15		gui=NONE
hi MsgSeparator		ctermbg=NONE	ctermfg=NONE	cterm=NONE                  guibg=NONE          guifg=NONE		    gui=NONE
hi MoreMsg		    ctermbg=NONE	ctermfg=13		cterm=bold                  guibg=NONE          guifg=g:color13		gui=bold
hi Pmenu		    ctermbg=1		ctermfg=15		cterm=NONE                  guibg=g:color1		guifg=g:color15		gui=NONE
    hi link NormalFloat Pmenu
    hi link WildMenu    Pmenu
hi PmenuSel		    ctermbg=3		ctermfg=15	    cterm=bold                  guibg=g:color3		guifg=g:color15		gui=bold
hi PmenuSbar		ctermbg=8		ctermfg=2   	cterm=NONE                  guibg=g:color8		guifg=g:color2		gui=NONE
hi PmenuThumb		ctermbg=1       ctermfg=15		cterm=NONE                  guibg=g:color1		guifg=g:color15		gui=NONE
hi SpecialKey		ctermbg=NONE	ctermfg=12		cterm=NONE                  guibg=NONE          guifg=g:color12		gui=NONE
hi SpellBad		    ctermbg=NONE	ctermfg=NONE	cterm=underline		        guibg=NONE		    guifg=NONE		    gui=underline
    hi link SpellCap    SpellBad
hi SpellLocal		ctermbg=NONE	ctermfg=NONE	cterm=NONE		            guibg=NONE		    guifg=NONE		    gui=NONE
    hi link SpellRare   SpellLocal
hi StatusLine		ctermbg=NONE	ctermfg=15		cterm=bold		            guibg=NONE		    guifg=g:color15		gui=bold
hi StatusLineNC		ctermbg=NONE	ctermfg=15		cterm=NONE                  guibg=NONE		    guifg=g:color15		gui=NONE
hi TabLine		    ctermbg=1		ctermfg=0		cterm=NONE                  guibg=g:color1		guifg=g:color0		gui=NONE
hi TabLineFill		ctermbg=1	    ctermfg=0	    cterm=NONE                  guibg=g:color1		guifg=g:color0		gui=NONE
hi TabLineSel		ctermbg=3		ctermfg=0		cterm=bold                  guibg=g:color3		guifg=g:color0		gui=bold
hi Title		    ctermbg=NONE	ctermfg=13		cterm=bold                  guibg=NONE		    guifg=g:color13		gui=bold
hi Visual		    ctermbg=8		ctermfg=NONE	cterm=NONE                  guibg=g:color8		guifg=NONE          gui=NONE
hi VisualNOS		ctermbg=1		ctermfg=NONE	cterm=NONE                  guibg=g:color1		guifg=NONE          gui=NONE
hi Whitespace		ctermbg=NONE	ctermfg=NONE	cterm=NONE                  guibg=NONE		    guifg=NONE		    gui=NONE
    hi link NonText     Whitespace

" Common Syntax Groups
hi Comment          ctermbg=NONE    ctermfg=9       cterm=italic		        guibg=NONE          guifg=g:color9		gui=italic
hi Constant         ctermbg=NONE    ctermfg=12      cterm=NONE		            guibg=NONE          guifg=g:color12		gui=NONE
hi String           ctermbg=NONE    ctermfg=10      cterm=NONE                  guibg=NONE          guifg=g:color10		gui=NONE
hi Boolean          ctermbg=NONE    ctermfg=12      cterm=bold                  guibg=NONE          guifg=g:color12		gui=bold
hi Identifier       ctermbg=NONE    ctermfg=11      cterm=NONE                  guibg=NONE          guifg=g:color11		gui=NONE
hi Function         ctermbg=NONE    ctermfg=14      cterm=bold                  guibg=NONE          guifg=g:color14		gui=bold
hi Statement        ctermbg=NONE    ctermfg=11      cterm=bold                  guibg=NONE          guifg=g:color11		gui=bold
hi PreProc          ctermbg=NONE    ctermfg=13      cterm=bold                  guibg=NONE          guifg=g:color13		gui=bold
hi Type             ctermbg=NONE    ctermfg=10      cterm=bold                  guibg=NONE          guifg=g:color10		gui=bold
hi Special          ctermbg=NONE    ctermfg=13      cterm=NONE                  guibg=NONE          guifg=g:color13		gui=NONE
hi Underlined       ctermbg=NONE    ctermfg=14      cterm=underline		        guibg=NONE          guifg=g:color14		gui=underline
hi Error            ctermbg=NONE    ctermfg=9       cterm=bold                  guibg=NONE          guifg=g:color9		gui=bold
hi Todo             ctermbg=NONE    ctermfg=15      cterm=bold                  guibg=NONE          guifg=g:color15		gui=bold

" Plugin-Specific
" -- vimwiki
hi VimwikiHeader1   ctermbg=NONE    ctermfg=14      cterm=bold,underline		guibg=NONE          guifg=g:color14		gui=bold,underline
hi VimwikiHeader2   ctermbg=NONE    ctermfg=9       cterm=bold,underline		guibg=NONE          guifg=g:color9		gui=bold,underline
hi VimwikiHeader3   ctermbg=NONE    ctermfg=10      cterm=bold,underline		guibg=NONE          guifg=g:color10		gui=bold,underline
hi VimwikiHeader4   ctermbg=NONE    ctermfg=11      cterm=bold,underline		guibg=NONE          guifg=g:color11		gui=bold,underline
hi VimwikiHeader5   ctermbg=NONE    ctermfg=12      cterm=bold,underline		guibg=NONE          guifg=g:color12		gui=bold,underline
hi VimwikiHeader6   ctermbg=NONE    ctermfg=13      cterm=bold,underline		guibg=NONE          guifg=g:color13		gui=bold,underline

" -- coc-nvim
hi link CocErrorSign    ErrorMsg
hi link CocWarningSign  WarningMsg
hi CocInfoSign      ctermbg=NONE    ctermfg=14      cterm=bold                  guibg=NONE          guifg=g:color14     gui=bold
hi CocHintSign      ctermbg=NONE    ctermfg=13      cterm=bold                  guibg=NONE          guifg=g:color13     gui=bold
