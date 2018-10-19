" Start of Vundle initialization
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Start of Vundle Plugin initialization

Plugin 'VundleVim/Vundle.vim'

" Basic
Plugin 'tpope/vim-unimpaired'            " bracket maps
Plugin 'tpope/vim-surround'              " manage surrounding brackets
Plugin 'tpope/vim-eunuch'                " unix command bindings
Plugin 'tpope/vim-sensible'              " basic settings
Plugin 'vim-airline/vim-airline'         " status line
Plugin 'tpope/vim-commentary'            " comment code
Plugin 'tommcdo/vim-lion'                " aligning
Plugin 'godlygeek/tabular'               " tables
Plugin 'dhruvasagar/vim-table-mode'      " tables
Plugin 'nathanaelkane/vim-indent-guides' " indent guides
Plugin 'terryma/vim-multiple-cursors'    " multiple cursors
Plugin 'junegunn/fzf.vim'                " fuzzy finder
Plugin 'lambdalisue/suda.vim'            " sudo write
Plugin 'tmhedberg/SimpylFold'            " folding
Plugin 'kana/vim-submode'                " submodes

" Features
Plugin 'scrooloose/nerdtree'             " file tree split
Plugin 'jistr/vim-nerdtree-tabs'         " tabs for NERDTree
Plugin 'ctrlpvim/ctrlp.vim'              " fuzzy finder
Plugin 'easymotion/vim-easymotion'       " immediate repeated motions
Plugin 'mbbill/undotree'                 " undo tree

" Git
Plugin 'tpope/vim-fugitive'              " git integration
Plugin 'airblade/vim-gitgutter'          " show git difference

" LINT
Plugin 'w0rp/ale'                        " linter

" Languages
" Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/deoplete.nvim'            " autocomplete

Plugin 'MarcWeber/vim-addon-mw-utils'    " utils
Plugin 'tomtom/tlib_vim'                 " utils
Plugin 'garbas/vim-snipmate'             " snippets
Plugin 'honza/vim-snippets'              " snippets

" Plugin 'python-mode/python-mode'
Plugin 'vim-scripts/indentpython.vim'    " indentation for python

Plugin 'lervag/vimtex'                   " latex support

" Plugin 'neovimhaskell/haskell-vim'
Plugin 'eagletmt/neco-ghc'               " haskell autocomplete
Plugin 'eagletmt/ghcmod-vim'             " ghc-mod integration
Plugin 'Shougo/vimproc'                  " library
Plugin 'parsonsmatt/intero-neovim'       " haskell interpreter inside vim
Plugin 'alx741/vim-hindent'              " indentation for haskell
Plugin 'alx741/vim-stylishask'           " formatting for haskell
Plugin 'dan-t/vim-hsimport'              " importing for haskell

" Visual
Plugin 'junegunn/limelight.vim'          " highlight only edited paragraph
Plugin 'junegunn/goyo.vim'               " distraction free

" Colorschemes
Plugin 'jnurmine/Zenburn'
Plugin 'altercation/vim-colors-solarized'
Plugin 'w0ng/vim-hybrid'
Plugin 'sickill/vim-monokai'
Plugin 'morhetz/gruvbox'
Plugin 'nanotech/jellybeans.vim'
Plugin 'sjl/badwolf'
Plugin 'reedes/vim-colors-pencil'

Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'flazz/vim-colorschemes'

" Nice colorschemes:
" gruvbox/deus, hybrid, hybrid_material, afterglow, angr, apprentice, pencil,
" badwolf

" End of Vundle Plugin initialization
"
call vundle#end()

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

" Functions

function! s:createnv()
    call inputsave()
    let l:new_env = input('New environment: ')
    call inputrestore()

    if empty(l:new_env) | return | endif

    execute "normal! o\\begin{" . l:new_env . "}\<CR>\\end{" . l:new_env . "}\<ESC>"
    call feedkeys ('O', 'n')

endfunction

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
set backupdir=~/.vim/backup
set directory=~/.vim/tmp

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
map <leader>n :NERDTreeToggle<CR>
map <leader>u :UndotreeToggle<CR>
map <F12> :set hls!<CR>
" map <F8> :PymodeLint<CR>
" map <F9> :PymodeLintAuto<CR>

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


" Commands
command Vimrc :tabnew ~/.vimrc

" Move by screen line and not by buffer line
source ~/.vim/physical_moves.vim

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

" Pymode
let g:pymode_python = 'python3'
let g:pymode_rope = 0

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_mode_map = {
"     \ "mode": "active",
"     \ "passive_filetypes": ["asm"] }
" let g:syntastic_quiet_messages = {
"     \ "regex": ['invalid syntax', 'too complex', 'mccabe'] }
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_chck_on_wq = 0

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1

" Indent Guides
let g:indent_guides_guide_size = 1
let g:indent_guides_color_change_percent = 3
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

nmap yce :<C-U>call <SID>createnv()<CR>

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
