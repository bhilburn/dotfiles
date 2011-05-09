" ViM Configuration File
" Ben Hilburn
" bhilburn@gmail.com
"
" Years in the making. Getting better through Science.
"
" Plugins configured:
"   Taglist: (included in most ViM installs)
"   OmniCPPComplete: (included in most ViM installs)
"   SuperTab: http://www.vim.org/scripts/script.php?script_id=182
"   Yankring: http://www.vim.org/scripts/script.php?script_id=1234
"   NerdTree: https://github.com/scrooloose/nerdtree
"   NerdCommenter: https://github.com/scrooloose/nerdcommenter
"   RainbowParentheses: http://git.hokietux.net/?p=configs.git&a=tree&f=vim/bundle/rainbow
"   Ack: https://github.com/mileszs/ack.vim
"   SnipMate: https://github.com/msanders/snipmate.vim
"   Syntastic: https://github.com/scrooloose/syntastic
"   Vim-Repeat: https://github.com/tpope/vim-repeat
"   Matchit: http://www.vim.org/scripts/script.php?script_id=39
"
" Note regarding RainbowParentheses:
"   There are many versions of this plugin. The one linked above is a version
"   stored in my git tree. I took Steve Losh's version, which works for gViM,
"   added definitions for terminal instances of ViM, and enabled all
"   bracket-matches by default.
"
" Note that some of the more popular plugins may be available through your
" distro's package manager.
"
" This configuration file also sets certain directories for backups, undo files,
" and the like. These directories must be manually created before they will work
" - otherwise, ViM will choke when attempting to write to them. Starts around
"   line 138 or so.
"
" Sets the leader key to ',', and creates a lot of keymappings with it. Current
" leader-key commands:
"   ,<space> - Switch off the last search to get rid of highlights
"   ,v - Re-select text that was just pasted
"   ,g - Create new vsplit, switch to it.
"   ,s - Show whitespace
"   ,W - Clean whitespace
"   ,r - Toggle Rainbows
"   ,/ - Open QuickFix window for last search
"   ,z - Disable / Enable folding
"
" Current Function Key mapping:
"   F1: Taglist
"   F2: NerdTree
"   F3: ErrorsToggle (func) - Only works with Python, at the moment.
"   F4: QFixToggle (func)
"   F5: Open
"   F6: Open
"   F7: Open
"   F8: Paste Toggle
"   F9: Vim Explorer
"   F10: Previous tab
"   F11: Next Tab
"   F12: New Tab
"
" Navigation mappings to get around C-w <nav>
"   C-h: Move to left window
"   C-l: Move to right window
"   C-j: Move down one window
"   C-k: Move up one window
"
" Other random key mappings:
"   Tab: mapped to '%' for bracket-matching
"   S-Tab: SuperTab completion
"   Space: Toggle fold under the cursor
"
" Note that this file contains some configuration options for gViM as well.
"
" Recently re-done, pulling some nifty features from Steve Losh's vimrc:
" Source: http://bitbucket.org/sjl/dotfiles/src/tip/vim/

" To enable Pathogen, we have to first disable the filetype, load the bundles,
" and then re-enable.
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" Ignore compatibility issues with Vi. Really don't know why ViM still defaults
" to this. Especially gViM.
set nocompatible

" General Options
set autoread
set history=1000
set scrolloff=15
set showmode
set showcmd
set ruler
set number
set numberwidth=4
set cursorline
set hidden
set title
set visualbell
set autoindent
set matchtime=3
set ttyfast
set cpoptions+=J
set list
set listchars=tab:▸\ ,eol:¬
set shell=/bin/zsh
set lazyredraw
set showbreak=↪

" Set options regarding the undo history and undo tree depth
set undofile
set undoreload=10000
set undolevels=512
set modelines=0

" Wildmode options, for command-line tab completion
set wildmenu
set wildchar=<Tab>
set wildmode=list:longest,full
set wildignore+=*.pyc,.hg,.git

" Set the terminal font encoding
set encoding=utf-8
set termencoding=utf-8

" Save when losing focus
au FocusLost * :wa

" Mouse options
set mouse=a
set mousemodel=popup

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" Spacing and tabbing
set expandtab
set smarttab
set softtabstop=4
set shiftwidth=4
set tabstop=4
set wrap
set textwidth=80
set formatoptions=qrn1
set colorcolumn=+1

" Get those annoying temporary files out of the working directory
set undodir=~/.vim/tmp/undo/     " undo files
set backupdir=~/.vim/tmp/backup/ " backups
set directory=~/.vim/tmp/swap/   " swap files
set backup                       " enable backups
let g:yankring_history_dir='~/.vim/tmp/yankring'

" Leader key remapping
let mapleader = ","
let maplocalleader = "\\"
map <leader><space> :noh<cr>

" Background, colorscheme, etc
set background=dark
set t_Co=256
colorscheme molokai-losh
syntax on

" Regex fixes
nnoremap / /\v
vnoremap / /\v

" Searching & Replacing
set hlsearch
set ignorecase
set smartcase
set incsearch
set showmatch
runtime macros/matchit.vim

" Keep search matches in the middle of the window.
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

" Pushing tab is much faster than shift-5 to match braces
map <tab> %

" L is easier to type than shift-4 for EOL shortcut
noremap L $

" Allow us to select non-text blocks while in visual mode for lazy stuff
set virtualedit+=block

" Some quick shortcuts for yanking and deleting lines.
nnoremap Y y$
nnoremap D d$

" Reselect text that was just pasted.
nnoremap <leader>v V`]

" Open a Quickfix window for the last search
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Fix linewise visual selection of various text objects
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

" Error navigation {{{
"
"             Location List     QuickFix Window
"            (e.g. Syntastic)     (e.g. Ack)
"            ----------------------------------
" Next      |     M-k               M-Down     |
" Previous  |     M-l                M-Up      |
"            ----------------------------------
" Ripped directly from Steve Losh
"
nnoremap ˚ :lnext<cr>zvzz
nnoremap ¬ :lprevious<cr>zvzz
inoremap ˚ <esc>:lnext<cr>zvzz
inoremap ¬ <esc>:lprevious<cr>zvzz
nnoremap <m-Down> :cnext<cr>zvzz
nnoremap <m-Up> :cprevious<cr>zvzz
" }}}

" Easy buffer navigation instead of the whole Ctrl-w crap.
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l
noremap <C-h>  <C-w>h
noremap <leader>g <C-w>v<C-w>l

" Map ,s to show whitespace so I can easily fix mixed tabs and spaces and
" other such nonsense.
set listchars=tab:>-,trail:·
nmap <silent> <leader>s :set nolist!<CR>

" Folding Settings
set foldlevelstart=100
set foldlevel=100 
set foldcolumn=4
set foldenable
set foldmethod=indent
set foldopen-=search
set foldopen-=undo

" Spacebar to toggle folds the cursor is over
nnoremap <Space> za
vnoremap <Space> za

" Set ,<space> to toggle all folds on/off
nnoremap <leader>z zi
vnoremap <leader>z zi

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Losh's fixes for annoying keys; his comments remain intact for posterity.
" Fuck you too, manual key.
nnoremap K <nop>

" Stop it, hash key.
inoremap # X<BS>#

" Formatting options:
"   t: Auto-wrap text
"   c: Auto-wrap comments
"   r: Auto-insert comment leader after <enter>
"   o: Auto-insert comment leader after o or O
"   q: Allow formatting of comments with 'gq'
"   n: Recognize lists and indent
"   1: If possible, break lines before one-letter words, not after
set formatoptions+=t,c,r,o,q,n,1

" Filetype-specific formatting
au FileType c,cpp,h set cindent formatoptions+=ro foldmethod=syntax
au FileType c set omnifunc=ccomplete#Complete
au FileType make set noexpandtab shiftwidth=8
au FileType tex SPCheck let dialect='US'
au Syntax {cpp,c,idl} runtime syntax/doxygen.vim
au BufRead,BufNewFile PKGBUILD set ts=2 sts=2 et sw=2
au FileType vim setlocal foldmethod=marker

" Filetype recognitition
au BufNewFile,BufRead .Xdefaults* set filetype=xdefaults
au BufNewFile,BufRead *-MIB.txt set filetype=mib

" Key mappings - ViM Explorer
nnoremap <silent> <F9> :Explore<CR>

" Key mappings - ViM tabs
nnoremap <silent> <F10> :tabp<CR>
nnoremap <silent> <F11> :tabn<CR>
nnoremap <silent> <F12> :tabnew<CR>

" Key mappings - silly quotes
nnoremap ` '
nnoremap ' `

" Key mappings - toggle paste mode
set pastetoggle=<F8>

" Key mappings - Yankring
nnoremap <silent> <F6> :YRShow<cr>

" Key mappings - Ack
map <leader>a :Ack 

" Key mappings - clean whitespace
map <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Status line settings
set laststatus=2
set statusline=%-3.3n\ %f%(\ %r%)%(\ %#WarningMsg#%m%0*%)%=(%l,\ %c)\ %P\ [%{&encoding}:%{&fileformat}]%(\ %w%)\ %y\
set shortmess+=aI
hi StatusLine term=inverse cterm=NONE ctermfg=white ctermbg=black
hi StatusLineNC term=none cterm=NONE ctermfg=darkgray ctermbg=black

" Some other fun graphical tidbits
highlight SpellBad term=underline gui=undercurl guisp=Orange
set fillchars=vert:│
set guicursor=n-c:block-Cursor-blinkon0
set guicursor+=v:block-vCursor-blinkon0
set guicursor+=i-ci:ver20-iCursor
set guioptions+=m

" Better Completion
set completeopt=longest,menuone
inoremap <expr> <CR>  pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-p> pumvisible() ? '<C-n>'  : '<C-n><C-r>=pumvisible() ? "\<lt>up>" : ""<CR>'
inoremap <expr> <C-n> pumvisible() ? '<C-n>'  : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Rainbow parentheses, which I love, so loading by default. Note that because
" syntax loading wipes out the rainbows, in order to have them 'on', by default,
" you must create an additional syntax file for that language.
nmap <leader>r :RainbowParenthesesToggle<CR>
runtime plugin/rainbow_parentheses.vim

" NERDTree settings
map <F2> :NERDTreeToggle<cr>
let NERDTreeIgnore=['.vim$', '\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index', 'xapian_index', '.*.pid', 'monitor.py', '.*-fixtures-.*.json', '.*\.o']

" Taglist is still awesome.
inoremap <F1> :TlistToggle<CR>
nnoremap <F1> :TlistToggle<CR>
vnoremap <F1> :TlistToggle<CR>

" Enable ViM's included LISP prettiness
let g:lisp_rainbow = 1

" Syntastic Configuration
let g:syntastic_enable_signs = 1
let g:syntastic_disabled_filetypes = ['html']

" Useful for editing syntax files. Thanks, Losh.
" Show the stack of syntax hilighting classes affecting whatever is under the
" cursor.
function! SynStack() " {{{
  if !exists("*synstack")
    return
  endif

  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nmap <M-S> :call SynStack()<CR> " }}}

" Error toggles, again, from Steve Losh
command! ErrorsToggle call ErrorsToggle()
function! ErrorsToggle() " {{{
  if exists("w:is_error_window")
    unlet w:is_error_window
    exec "q"
  else
    exec "Errors"
    lopen
    let w:is_error_window = 1
  endif
endfunction " }}}

command! -bang -nargs=? QFixToggle call QFixToggle(<bang>0)
function! QFixToggle(forced) " {{{
  if exists("g:qfix_win") && a:forced == 0
    cclose
    unlet g:qfix_win
  else
    copen 10
    let g:qfix_win = bufnr("$")
  endif
endfunction " }}}

nmap <silent> <F3> :ErrorsToggle<cr>
nmap <silent> <F4> :QFixToggle<cr>

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
