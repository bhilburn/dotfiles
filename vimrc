" Turn on syntax highlighting
syntax on

" General Options
set nocompatible
set autoread
set undofile

" Background, colorscheme, etc
set background=dark
set t_Co=256
colorscheme desert256

" Utility features
set ruler
set number
set cursorline
set history=1000
set hidden
set title
set scrolloff=15
set visualbell
set undolevels=512
set autoindent
set showmatch

" Wildmode options, for command-line tab completion
set wildmenu
set wildchar=<Tab>
set wildmode=list:longest,full

" Set the terminal font encoding
set encoding=utf-8
set termencoding=utf-8

" Turn plugin features on
filetype on
filetype plugin on
filetype indent on

" Mouse options
set mouse=a
set mousemodel=popup

" Spacing and tabbing
set expandtab
set smarttab
set softtabstop=4
set shiftwidth=4
set tabstop=4
set wrap
"set nowrap

" Filetype-specific formatting
set formatoptions+=t,c,r,o,n

au FileType c,cpp,h set cindent formatoptions+=ro tw=80
au FileType c set omnifunc=ccomplete#Complete tw=80
au FileType make set noexpandtab shiftwidth=8 tw=80
au FileType python set et sw=4 sts=4 ts=4 tw=80 ai
au FileType html,xhtml set tw=0
au FileType tex SPCheck
au FileType tex let dialect='US'
au Syntax {cpp,c,idl} runtime syntax/doxygen.vim
au BufRead,BufNewFile PKGBUILD set ts=2 sts=2 et sw=2

" Filetype recognitition
au BufNewFile,BufRead .Xdefaults* set filetype=xdefaults
au BufNewFile,BufRead *-MIB.txt set filetype=mib

" Key mappings
nnoremap <silent> <F7> :Explore<CR>
nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <F9> :tabnew<CR>
nnoremap <silent> <F10> :tabp<CR>
nnoremap <silent> <F11> :tabn<CR>
"---------------- <F12> unmapped
nnoremap ` '
nnoremap ' `
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" Map ,s to show whitespace
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" Status line settings
set laststatus=2
set statusline=%-3.3n\ %f%(\ %r%)%(\ %#WarningMsg#%m%0*%)%=(%l,\ %c)\ %P\ [%{&encoding}:%{&fileformat}]%(\ %w%)\ %y\
set shortmess+=aI
set showcmd
hi StatusLine term=inverse cterm=NONE ctermfg=white ctermbg=black
hi StatusLineNC term=none cterm=NONE ctermfg=darkgray ctermbg=black

" Command-mode completions
set wildmode=list:longest

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Folding
if has("folding")
    set foldenable 
    set foldmethod=indent 
    set foldlevel=100 
    set foldopen-=search
    set foldopen-=undo
endif

hi Folded term=standout ctermfg=3 ctermbg=0

" Searching & Replacing
set hlsearch
set ignorecase
set smartcase
set incsearch
runtime macros/matchit.vim

" Taglist settings
let Tlist_Process_File_Always = 1
let Tlist_Auto_Highlight_Tag = 1
let Tlist_Auto_Update = 1
let Tlist_Enable_Fold_Column = 1
let Tlist_Highlight_Tag_On_BufEnter = 1
let Tlist_Max_Tag_Length = 35
let Tlist_Use_Right_Window = 1
let Tlist_Inc_Winwidth = 0
let Tlist_WinWidth = 40

" OmniCPPComplete settings
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_NamespaceSearch = 1
let OmniCpp_DisplayMode = 1
let OmniCpp_ShowScopeInAbbr = 0
let OmniCpp_ShowPrototypeInAbbr = 0
let OmniCpp_ShowAccess = 1
let OmniCpp_DefaultNamespaces = ["std"]
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 0
let OmniCpp_SelectFirstItem = 0

" SuperTab plugin settings
let g:SuperTabDefaultCompletionType = "<C-P>"
let g:SuperTabRetainCompletionType = 1
let g:SuperTabMappingForward = '<s-tab>'
let g:SuperTabMappingBackward = '<s-c-tab>'

