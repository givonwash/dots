" Walle x Lightline Colorscheme

" Useful Blocks
" -- gui-colors
if exists('color0') && exists('color15')
    let s:gnor = [string(g:color0), string(g:color9)]
    let s:gins = [string(g:color0), string(g:color11)]
    let s:grep = [string(g:color0), string(g:color11)]
    let s:gvis = [string(g:color0), string(g:color10)]
    let s:gina = [string(g:color0), string(g:color15)]
else
    let s:gnor = ['', '']
    let s:gins = ['', '']
    let s:grep = ['', '']
    let s:gvis = ['', '']
    let s:gina = ['', '']
endif

" -- cterm-colors
let s:cnor = [0, 9]
let s:cins = [0, 11]
let s:crep = [0, 11]
let s:cvis = [0, 10]
let s:cina = [0, 15]

" -- gui-colors + cterm-colors
let s:nor = s:gnor + s:cnor
let s:ins = s:gins + s:cins
let s:rep = s:grep + s:crep
let s:vis = s:gvis + s:cvis
let s:ina = s:gina + s:cina

" -- 'reverses' of gui-colors + cterm-colors
let s:rnor = reverse(copy(s:gnor)) + reverse(copy(s:cnor))
let s:rins = reverse(copy(s:gins)) + reverse(copy(s:cins))
let s:rrep = reverse(copy(s:grep)) + reverse(copy(s:crep))
let s:rvis = reverse(copy(s:gvis)) + reverse(copy(s:cvis))
let s:rina = reverse(copy(s:gina)) + reverse(copy(s:cina))

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
let s:p.inactive.left = [s:rina]
let s:p.inactive.middle = [s:rina]
let s:p.inactive.right = [s:ina, s:rina]
let s:p.tabline.left = [s:tab]
let s:p.tabline.middle = [s:tab]
let s:p.tabline.right = [s:tabsel]
let s:p.tabline.tabsel = [s:tabsel]

let g:lightline#colorscheme#walle#palette = s:p
