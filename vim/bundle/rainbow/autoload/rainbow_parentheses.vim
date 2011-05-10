"------------------------------------------------------------------------------
"  Description: Rainbow colors for parentheses, based on rainbow_parenthsis.vim
"               by Martin Krischik and others.  This version cleans things up,
"               simplifies a few things, and changes "parenthsis" to
"               "parentheses".
"
"               This version has been edited by bhilburn to enable rainbows in
"               terminal ViM instances. Also, all types of rainbow highlighting
"               are now activated by default: () [] {} <>
"------------------------------------------------------------------------------

" Section: highlight {{{1

function! rainbow_parentheses#Activate()
    highlight default levelr1c   ctermfg=red guifg=red
    highlight default levelr2c   ctermfg=cyan guifg=orange
    highlight default levelr3c   ctermfg=yellow guifg=yellow
    highlight default levelr4c   ctermfg=green guifg=green
    highlight default levelr5c   ctermfg=blue guifg=chartreuse1
    highlight default levelr6c   ctermfg=magenta guifg=OrangeRed1
    highlight default levelr7c   ctermfg=red guifg=LightGoldenRod1
    highlight default levelr8c   ctermfg=cyan guifg=DeepSkyBlue1
    highlight default levelr9c   ctermfg=yellow guifg=HotPink1
    highlight default levelr10c  ctermfg=green guifg=chartreuse1
    highlight default levelr11c  ctermfg=blue guifg=OrangeRed1
    highlight default levelr12c  ctermfg=magenta guifg=LightGoldenRod1
    highlight default levelr13c  ctermfg=red guifg=DeepSkyBlue1
    highlight default levelr14c  ctermfg=cyan guifg=HotPink1
    highlight default levelr15c  ctermfg=yellow guifg=chartreuse1
    highlight default levelr16c  ctermfg=green guifg=Yellow

    highlight default levels1c   ctermfg=red guifg=red
    highlight default levels2c   ctermfg=cyan guifg=orange
    highlight default levels3c   ctermfg=yellow guifg=yellow
    highlight default levels4c   ctermfg=green guifg=green
    highlight default levels5c   ctermfg=blue guifg=chartreuse1
    highlight default levels6c   ctermfg=magenta guifg=OrangeRed1
    highlight default levels7c   ctermfg=red guifg=LightGoldenRod1
    highlight default levels8c   ctermfg=cyan guifg=DeepSkyBlue1
    highlight default levels9c   ctermfg=yellow guifg=HotPink1
    highlight default levels10c  ctermfg=green guifg=chartreuse1
    highlight default levels11c  ctermfg=blue guifg=OrangeRed1
    highlight default levels12c  ctermfg=magenta guifg=LightGoldenRod1
    highlight default levels13c  ctermfg=red guifg=DeepSkyBlue1
    highlight default levels14c  ctermfg=cyan guifg=HotPink1
    highlight default levels15c  ctermfg=yellow guifg=chartreuse1
    highlight default levels16c  ctermfg=green guifg=Yellow

    highlight default levelb1c   ctermfg=red guifg=red
    highlight default levelb2c   ctermfg=cyan guifg=orange
    highlight default levelb3c   ctermfg=yellow guifg=yellow
    highlight default levelb4c   ctermfg=green guifg=green
    highlight default levelb5c   ctermfg=blue guifg=chartreuse1
    highlight default levelb6c   ctermfg=magenta guifg=OrangeRed1
    highlight default levelb7c   ctermfg=red guifg=LightGoldenRod1
    highlight default levelb8c   ctermfg=cyan guifg=DeepSkyBlue1
    highlight default levelb9c   ctermfg=yellow guifg=HotPink1
    highlight default levelb10c  ctermfg=green guifg=chartreuse1
    highlight default levelb11c  ctermfg=blue guifg=OrangeRed1
    highlight default levelb12c  ctermfg=magenta guifg=LightGoldenRod1
    highlight default levelb13c  ctermfg=red guifg=DeepSkyBlue1
    highlight default levelb14c  ctermfg=cyan guifg=HotPink1
    highlight default levelb15c  ctermfg=yellow guifg=chartreuse1
    highlight default levelb16c  ctermfg=green guifg=Yellow

    highlight default levelc1c   ctermfg=red guifg=red
    highlight default levelc2c   ctermfg=cyan guifg=orange
    highlight default levelc3c   ctermfg=yellow guifg=yellow
    highlight default levelc4c   ctermfg=green guifg=green
    highlight default levelc5c   ctermfg=blue guifg=chartreuse1
    highlight default levelc6c   ctermfg=magenta guifg=OrangeRed1
    highlight default levelc7c   ctermfg=red guifg=LightGoldenRod1
    highlight default levelc8c   ctermfg=cyan guifg=DeepSkyBlue1
    highlight default levelc9c   ctermfg=yellow guifg=HotPink1
    highlight default levelc10c  ctermfg=green guifg=chartreuse1
    highlight default levelc11c  ctermfg=blue guifg=OrangeRed1
    highlight default levelc12c  ctermfg=magenta guifg=LightGoldenRod1
    highlight default levelc13c  ctermfg=red guifg=DeepSkyBlue1
    highlight default levelc14c  ctermfg=cyan guifg=HotPink1
    highlight default levelc15c  ctermfg=yellow guifg=chartreuse1
    highlight default levelc16c  ctermfg=green guifg=Yellow

    call rainbow_parentheses#LoadRound()
    call rainbow_parentheses#LoadSquare()
    call rainbow_parentheses#LoadBraces()
    call rainbow_parentheses#LoadChevrons()

    let s:rainbow_paren_active = 1
endfunction

function! rainbow_parentheses#Clear()
    let i = 0
    while i != 16
        let i = i + 1
        exe 'highlight clear level' . i . 'c'
    endwhile
    let s:rainbow_paren_active = 0
endfunction

function! rainbow_parentheses#Toggle ()
    if !exists('s:rainbow_paren_active')
        call rainbow_parentheses#LoadRound()
        call rainbow_parentheses#LoadSquare()
        call rainbow_parentheses#LoadBraces()
        call rainbow_parentheses#LoadChevrons()
    endif
    if s:rainbow_paren_active != 0
        call rainbow_parentheses#Clear()
    else
        call rainbow_parentheses#Activate()
    endif
endfunction

" Section: syntax {{{1

syntax cluster  rainbow_parentheses contains=@TOP,level1,level2,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15,level16,NoInParens

" Subsection: parentheses or round brackets: {{{2
"
function! rainbow_parentheses#LoadRound ()
    syntax region level1 matchgroup=levelr1c start=/(/ end=/)/ contains=TOP,level1,level2,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level2 matchgroup=levelr2c start=/(/ end=/)/ contains=TOP,level2,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level3 matchgroup=levelr3c start=/(/ end=/)/ contains=TOP,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level4 matchgroup=levelr4c start=/(/ end=/)/ contains=TOP,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level5 matchgroup=levelr5c start=/(/ end=/)/ contains=TOP,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level6 matchgroup=levelr6c start=/(/ end=/)/ contains=TOP,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level7 matchgroup=levelr7c start=/(/ end=/)/ contains=TOP,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level8 matchgroup=levelr8c start=/(/ end=/)/ contains=TOP,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level9 matchgroup=levelr9c start=/(/ end=/)/ contains=TOP,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level10 matchgroup=levelr10c start=/(/ end=/)/ contains=TOP,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level11 matchgroup=levelr11c start=/(/ end=/)/ contains=TOP,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level12 matchgroup=levelr12c start=/(/ end=/)/ contains=TOP,level12,level13,level14,level15, level16,NoInParens
    syntax region level13 matchgroup=levelr13c start=/(/ end=/)/ contains=TOP,level13,level14,level15, level16,NoInParens
    syntax region level14 matchgroup=levelr14c start=/(/ end=/)/ contains=TOP,level14,level15, level16,NoInParens
    syntax region level15 matchgroup=levelr15c start=/(/ end=/)/ contains=TOP,level15, level16,NoInParens
    syntax region level16 matchgroup=levelr16c start=/(/ end=/)/ contains=TOP,level16,NoInParens
    let s:rainbow_paren_active = 0
endfunction

" Subsection: box brackets or square brackets: {{{2
"
function! rainbow_parentheses#LoadSquare ()
    syntax region level1 matchgroup=levels1c start=/\[/ end=/\]/ contains=TOP,level1,level2,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level2 matchgroup=levels2c start=/\[/ end=/\]/ contains=TOP,level2,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level3 matchgroup=levels3c start=/\[/ end=/\]/ contains=TOP,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level4 matchgroup=levels4c start=/\[/ end=/\]/ contains=TOP,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level5 matchgroup=levels5c start=/\[/ end=/\]/ contains=TOP,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level6 matchgroup=levels6c start=/\[/ end=/\]/ contains=TOP,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level7 matchgroup=levels7c start=/\[/ end=/\]/ contains=TOP,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level8 matchgroup=levels8c start=/\[/ end=/\]/ contains=TOP,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level9 matchgroup=levels9c start=/\[/ end=/\]/ contains=TOP,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level10 matchgroup=levels10c start=/\[/ end=/\]/ contains=TOP,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level11 matchgroup=levels11c start=/\[/ end=/\]/ contains=TOP,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level12 matchgroup=levels12c start=/\[/ end=/\]/ contains=TOP,level12,level13,level14,level15, level16,NoInParens
    syntax region level13 matchgroup=levels13c start=/\[/ end=/\]/ contains=TOP,level13,level14,level15, level16,NoInParens
    syntax region level14 matchgroup=levels14c start=/\[/ end=/\]/ contains=TOP,level14,level15, level16,NoInParens
    syntax region level15 matchgroup=levels15c start=/\[/ end=/\]/ contains=TOP,level15, level16,NoInParens
    syntax region level16 matchgroup=levels16c start=/\[/ end=/\]/ contains=TOP,level16,NoInParens
    let s:rainbow_paren_active = 0
endfunction

" Subsection: curly brackets or braces: {{{2
"
function! rainbow_parentheses#LoadBraces ()
    syntax region level1 matchgroup=levelb1c start=/{/ end=/}/ contains=TOP,level1,level2,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level2 matchgroup=levelb2c start=/{/ end=/}/ contains=TOP,level2,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level3 matchgroup=levelb3c start=/{/ end=/}/ contains=TOP,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level4 matchgroup=levelb4c start=/{/ end=/}/ contains=TOP,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level5 matchgroup=levelb5c start=/{/ end=/}/ contains=TOP,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level6 matchgroup=levelb6c start=/{/ end=/}/ contains=TOP,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level7 matchgroup=levelb7c start=/{/ end=/}/ contains=TOP,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level8 matchgroup=levelb8c start=/{/ end=/}/ contains=TOP,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level9 matchgroup=levelb9c start=/{/ end=/}/ contains=TOP,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level10 matchgroup=levelb10c start=/{/ end=/}/ contains=TOP,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level11 matchgroup=levelb11c start=/{/ end=/}/ contains=TOP,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level12 matchgroup=levelb12c start=/{/ end=/}/ contains=TOP,level12,level13,level14,level15, level16,NoInParens
    syntax region level13 matchgroup=levelb13c start=/{/ end=/}/ contains=TOP,level13,level14,level15, level16,NoInParens
    syntax region level14 matchgroup=levelb14c start=/{/ end=/}/ contains=TOP,level14,level15, level16,NoInParens
    syntax region level15 matchgroup=levelb15c start=/{/ end=/}/ contains=TOP,level15, level16,NoInParens
    syntax region level16 matchgroup=levelb16c start=/{/ end=/}/ contains=TOP,level16,NoInParens
    let s:rainbow_paren_active = 0
endfunction

" Subsection: angle brackets or chevrons: {{{2
"
function! rainbow_parentheses#LoadChevrons ()
    syntax region level1 matchgroup=levelc1c start=/</ end=/>/ contains=TOP,level1,level2,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level2 matchgroup=levelc2c start=/</ end=/>/ contains=TOP,level2,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level3 matchgroup=levelc3c start=/</ end=/>/ contains=TOP,level3,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level4 matchgroup=levelc4c start=/</ end=/>/ contains=TOP,level4,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level5 matchgroup=levelc5c start=/</ end=/>/ contains=TOP,level5,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level6 matchgroup=levelc6c start=/</ end=/>/ contains=TOP,level6,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level7 matchgroup=levelc7c start=/</ end=/>/ contains=TOP,level7,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level8 matchgroup=levelc8c start=/</ end=/>/ contains=TOP,level8,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level9 matchgroup=levelc9c start=/</ end=/>/ contains=TOP,level9,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level10 matchgroup=levelc10c start=/</ end=/>/ contains=TOP,level10,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level11 matchgroup=levelc11c start=/</ end=/>/ contains=TOP,level11,level12,level13,level14,level15, level16,NoInParens
    syntax region level12 matchgroup=levelc12c start=/</ end=/>/ contains=TOP,level12,level13,level14,level15, level16,NoInParens
    syntax region level13 matchgroup=levelc13c start=/</ end=/>/ contains=TOP,level13,level14,level15, level16,NoInParens
    syntax region level14 matchgroup=levelc14c start=/</ end=/>/ contains=TOP,level14,level15, level16,NoInParens
    syntax region level15 matchgroup=levelc15c start=/</ end=/>/ contains=TOP,level15, level16,NoInParens
    syntax region level16 matchgroup=levelc16c start=/</ end=/>/ contains=TOP,level16,NoInParens
    let s:rainbow_paren_active = 0
endfunction

" }}}1

finish
