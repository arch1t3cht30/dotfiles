call plug#begin('~/.local/share/nvim/plugged')

" Basic
Plug 'tpope/vim-unimpaired'              " bracket maps
Plug 'tpope/vim-surround'                " manage surrounding brackets
Plug 'tpope/vim-eunuch'                  " unix command bindings
Plug 'tpope/vim-sensible'                " basic settings
Plug 'tpope/vim-repeat'                  " repeat plugin commands
Plug 'vim-airline/vim-airline'           " status line
Plug 'tpope/vim-commentary'              " comment code
Plug 'tommcdo/vim-lion'                  " aligning
" Plug 'godlygeek/tabular'                 " tables
" Plug 'dhruvasagar/vim-table-mode'        " tables
" Plug 'nathanaelkane/vim-indent-guides'   " indent guides
Plug 'terryma/vim-multiple-cursors'      " multiple cursors
" Plug 'junegunn/fzf.vim'                  " fuzzy finder
Plug 'lambdalisue/suda.vim'              " sudo write
Plug 'tmhedberg/SimpylFold'              " folding
Plug 'kana/vim-submode'                  " submodes

" Features
Plug 'scrooloose/nerdtree'               " file tree split
Plug 'jistr/vim-nerdtree-tabs'           " tabs for NERDTree
" Plug 'ctrlpvim/ctrlp.vim'                " fuzzy finder
Plug 'easymotion/vim-easymotion'         " immediate repeated motions
Plug 'mbbill/undotree'                   " undo tree

" Git
Plug 'tpope/vim-fugitive'                " git integration
Plug 'airblade/vim-gitgutter'            " show git difference

" LINT
Plug 'w0rp/ale'                          " linter

" Languages
" Plugin 'Valloric/YouCompleteMe'
Plug 'Shougo/deoplete.nvim'              " autocomplete

Plug 'MarcWeber/vim-addon-mw-utils'      " utils
Plug 'tomtom/tlib_vim'                   " utils
Plug 'sirver/ultisnips'                  " snippets

" Plugin 'python-mode/python-mode'
Plug 'vim-scripts/indentpython.vim'      " indentation for python

Plug 'lervag/vimtex'                     " latex support

" Plugin 'neovimhaskell/haskell-vim'
Plug 'eagletmt/neco-ghc'                 " haskell autocomplete
Plug 'eagletmt/ghcmod-vim'               " ghc-mod integration
Plug 'Shougo/vimproc'                    " library
Plug 'parsonsmatt/intero-neovim'         " haskell interpreter inside vim
Plug 'alx741/vim-hindent'                " indentation for haskell
Plug 'alx741/vim-stylishask'             " formatting for haskell
Plug 'dan-t/vim-hsimport'                " importing for haskell

" Visual
Plug 'junegunn/limelight.vim'            " highlight only edited paragraph
Plug 'junegunn/goyo.vim'                 " distraction free

" Colorschemes
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'w0ng/vim-hybrid'
Plug 'sickill/vim-monokai'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'sjl/badwolf'
Plug 'reedes/vim-colors-pencil'

Plug 'rafi/awesome-vim-colorschemes'
Plug 'flazz/vim-colorschemes'

" Nice colorschemes:
" gruvbox/deus, hybrid, hybrid_material, afterglow, angr, apprentice, pencil,
" badwolf, OceanicNext

call plug#end()

" OS specific
if has("unix")
    let s:uname = substitute(system("uname -n"), '\n', '', '')
    if s:uname == "theoarch"
        nnoremap <F2> :silent !urxvt<CR><CR>
    endif
    if s:uname == "TheoKali"
        nnoremap <F2> :!gnome-terminal<CR><CR>
    endif
endif


filetype plugin indent on

" " Forbid hjlk (temporary)
" nnoremap h <NOP>
" nnoremap j <NOP>
" nnoremap k <NOP>
" nnoremap l <NOP>

" Forbid Arrow Keys
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>

" General options

set encoding=utf-8

set rnu
set nu

syntax on
let python_highlight_all=1
filetype on
filetype indent on
filetype plugin on

set tabstop=4
set shiftwidth=4
set smartindent
set expandtab

set wrap
set linebreak
set breakindent
set breakindentopt=shift:2

set mouse=a

set ignorecase
set smartcase
set incsearch
set hlsearch

set nohidden

set backup
set backupdir=~/.local/share/nvim/backup
set directory=~/.local/share/nvim/tmp

set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

set updatetime=100

" PEP8-formatting
au BufNewFile,BufRead *.py
    \ set tabstop=4         |
    \ set softtabstop=4     |
    \ set shiftwidth=4      |
    \ set textwidth=79      |
    \ set expandtab         |
    \ set autoindent        |
    \ set fileformat=unix   |

" Persistent undo
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    silent call system('mkdir ' . vimDir)
    silent call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" Enable folding
set foldmethod=indent
set foldlevel=99

" Bindings
let mapleader=","

inoremap <F1> <Esc>
nnoremap ci$ T$ct$
nnoremap yi$ T$yt$
nnoremap di$ T$dt$
nnoremap <space> za
nnoremap <leader>b ,
nnoremap ä ,
nnoremap ö %
map <leader>n :NERDTreeToggle<CR>
map <leader>u :UndotreeToggle<CR>
map <F12> :set hls!<CR>

nnoremap <leader>w :w suda://%<CR>
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>t :split term://bash<CR>
nnoremap <leader>vt :vsplit term://bash<CR>

" Submode for resizing
let g:submode_always_show_submode = 1
let g:submode_timeoutlen = 2000
call submode#enter_with('window', 'n', '', '<C-M-w>')
call submode#leave_with('window', 'n', '', '<ESC>')

for key in ['a','b','c','d','e','f','g','h','i','j','k','l','m',
\           'n','o','p','q','r','s','t','u','v','w','x','y','z']
    call submode#map('window', 'n', '', key, '<C-w>' . key)
    call submode#map('window', 'n', '', toupper(key), '<C-w>' . toupper(key))
    call submode#map('window', 'n', '', '<C-' . key . '>', '<C-w>' . '<C-' . key . '>')
endfor
for key in ['=', '_', '+', '-', '<', '>']
    call submode#map('window', 'n', '', key, '<C-w>' . key)
endfor


" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>


" Snippets
let g:UltiSnipsExpandTrigger       = '<tab>'
let g:UltiSnipsJumpForwardTrigger  = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" let g:UltiSnipsSnippetsDirectories = ['~/.vim/UltiSnips']
let g:UltiSnipsEditSplit           = 'tabdo'

" Commands
command Vimrc :tabnew ~/.config/nvim/init.vim

" Move by screen line and not by buffer line
source ~/.config/nvim/physical_moves.vim

" Plugin configuration

" ALE
let g:ale_linters = {'python': ['pyflakes', 'flake8'],
                   \ 'haskell': ['stack-ghc', 'ghc-mod', 'hlint', 'hdevtools'],}
let g:ale_type_map = {'flake8': {'ES': 'WS', 'E': 'W'}}
nnoremap <buffer> <leader>l :call ale#cursor#ShowCursorDetail()<cr><C-W>j

nnoremap <silent> <leader>aj :lnext<cr>
nnoremap <silent> <leader>ak :lprev<cr>
nnoremap <silent> <leader>ac <C-W>k:q<cr>

" Don't resize splits after closing others
set noea

" let g:ale_sign_error = '✘'
" let g:ale_sign_warning = '⚠'
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=None ctermfg=yellow

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" Indent Guides
" let g:indent_guides_guide_size = 1
" let g:indent_guides_color_change_percent = 3
" let g:indent_guides_enable_on_vim_startup = 1

" Solarized
if has('gui_running')
    set background=dark
    colorscheme solarized
else
    " colorscheme gruvbox
    colorscheme badwolf
    set background=dark
endif

" TeX file configuration
autocmd BufNewFile,BufRead *.tex set syntax=context
autocmd FileType tex let b:surround_101 = "\\begin{equation*}\n    \r\n\\end{equation*}\n"
autocmd FileType tex let b:surround_36 = "$\n$"

let g:vimtex_view_method = 'zathura'
let g:tex_flavor = 'latex'
let g:vimtex_compiler_progname = 'nvr'

" NERDTree

let NERDTreeIgnore=['\.pyc$', '\~$']

" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>

" YCM
" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'


" YCM Support for Vimtex
" if !exists('g:ycm_semantic_triggers')
"   let g:ycm_semantic_triggers = {}
" endif
" let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
