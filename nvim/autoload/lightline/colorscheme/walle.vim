" Walle x Lightline Colorscheme

" Useful Blocks
" -- gui-colors
if exists('color0') && exists('color15')
    let s:gnor = [string(g:color15), string(g:color1)]
    let s:gins = [string(g:color15), string(g:color3)]
    let s:grep = [string(g:color15), string(g:color3)]
    let s:gvis = [string(g:color15), string(g:color2)]
    let s:gina = [string(g:color15), string(g:color0)]
else
    let s:gnor = ['', '']
    let s:gins = ['', '']
    let s:grep = ['', '']
    let s:gvis = ['', '']
    let s:gina = ['', '']
endif

" -- cterm-colors
let s:cnor = [15, 1]
let s:cins = [15, 3]
let s:crep = [15, 3]
let s:cvis = [15, 2]
let s:cina = [15, 0]

" -- gui-colors + cterm-colors
let s:nor = s:gnor + s:cnor
let s:ins = s:gins + s:cins
let s:rep = s:grep + s:crep
let s:vis = s:gvis + s:cvis
let s:ina = s:gina + s:cina

" -- 'reverses' of gui-colors + cterm-colors
let s:rnor = [s:gnor[1], [g:color0], s:cnor[1], 0]
let s:rins = [s:gins[1], [g:color0], s:cins[1], 0]
let s:rrep = [s:grep[1], [g:color0], s:crep[1], 0]
let s:rvis = [s:gvis[1], [g:color0], s:cvis[1], 0]

" -- tabs
let s:tab = s:rnor 
let s:tabsel = s:nor

" Palette
let s:p = {
    \ 'normal': {},
    \ 'insert': {},
    \ 'replace': {},
    \ 'visual': {},
    \ 'inactive': {},
    \ 'tabline': {}
  \ }

let s:p.normal.left = [s:nor + ['bold'], s:rins]
let s:p.normal.middle = [s:rnor]
let s:p.normal.right = [s:nor, s:ins, s:rins]
let s:p.insert.left = [s:ins + ['bold'], s:rins]
let s:p.insert.middle = [s:rins]
let s:p.insert.right = [s:ins, s:nor, s:rins]
let s:p.replace.left = [s:rep + ['bold'], s:rins]
let s:p.replace.middle = [s:rrep]
let s:p.replace.right = [s:rep, s:nor, s:rins]
let s:p.visual.left = [s:vis + ['bold'], s:rins]
let s:p.visual.middle = [s:rvis]
let s:p.visual.right = [s:vis, s:ins, s:rins]
let s:p.inactive.left = [s:ina]
let s:p.inactive.right = [s:ina, s:ina]
let s:p.tabline.left = [s:tab]
let s:p.tabline.middle = [s:tab]
let s:p.tabline.right = [s:tabsel]
let s:p.tabline.tabsel = [s:tabsel]

let g:lightline#colorscheme#walle#palette = s:p
