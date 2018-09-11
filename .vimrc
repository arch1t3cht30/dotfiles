" Start of Vundle initialization
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Start of Vundle Plugin initialization

Plugin 'VundleVim/Vundle.vim'

" Basic
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-sensible'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-commentary'
Plugin 'tommcdo/vim-lion'
Plugin 'godlygeek/tabular'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'junegunn/fzf.vim'
Plugin 'lambdalisue/suda.vim'

" Features
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'mbbill/undotree'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'tmhedberg/SimpylFold'

" LINT
Plugin 'w0rp/ale'

" Languages
" Plugin 'Valloric/YouCompleteMe'
Plugin 'Shougo/deoplete.nvim'
Plugin 'ervandew/supertab'

Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" Plugin 'python-mode/python-mode'
Plugin 'vim-scripts/indentpython.vim'

Plugin 'lervag/vimtex'

" Plugin 'neovimhaskell/haskell-vim'
Plugin 'eagletmt/neco-ghc'
Plugin 'eagletmt/ghcmod-vim'
Plugin 'Shougo/vimproc'
Plugin 'parsonsmatt/intero-neovim'
Plugin 'alx741/vim-hindent'
Plugin 'alx741/vim-stylishask'
Plugin 'dan-t/vim-hsimport'

" Visual
Plugin 'junegunn/limelight.vim'
Plugin 'junegunn/goyo.vim'

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
map <leader>n :NERDTreeToggle<CR>
map <leader>u :UndotreeToggle<CR>
map <F12> :set hls!<CR>
" map <F8> :PymodeLint<CR>
" map <F9> :PymodeLintAuto<CR>

nnoremap <leader>w :w suda://%<CR>
tnoremap <Esc> <C-\><C-n>

" Commands
command Vimrc :tabnew ~/.vimrc

" Haskell
nnoremap <Leader>hw :w<cr>:GhcModTypeInsert<cr>
nnoremap <Leader>hs :w<cr>:GhcModSplitFunCase<cr>
nnoremap <Leader>hq :w<cr>:GhcModType<cr>
nnoremap <Leader>he :w<cr>:GhcModTypeClear<cr>

nnoremap <Leader>hi :InteroOpen<cr>
nnoremap <Leader>hc :InteroHide<cr>
nnoremap <Leader>hl :InteroLoadCurrentFile<cr>
nnoremap <Leader>hr :InteroReload<cr>
nnoremap <Leader>hd :IntegroGoToDef

autocmd FileType haskell nnoremap <buffer> <leader>l :call ale#cursor#ShowCursorDetail()<cr>

let g:ghcmod_use_basedir = '$HOME/.local/bin/ghc-mod'

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0

" neco-ghc
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:ncoghc_enable_detailed_browse = 1

let g:hindent_on_save = 0
au FileType haskell nnoremap <silent> <leader>ph :Hindent<CR>
au FileType haskell nnoremap <silent> <leader>ps :Stylishsk<CR>

au FileType haskell nnoremap <silent> <leader>ims :HsimportSymbol<CR>
au FileType haskell nnoremap <silent> <leader>imm :HsimportModule<CR>

let g:stylishask_on_save = 0

" Move by screen line and not by buffer line
source ~/.vim/physical_moves.vim

" Plugin configuration

" ALE

let b:ale_linters = ['pyflakes', 'flake8', 'pylint', 'stack-ghc', 'ghc-mod', 'hlint', 'hdevtools']

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

nmap yce :<C-U>call <SID>createnv()<CR>

" NERDTree

let NERDTreeIgnore=['\.pyc$', '\~$']

" deoplete
let g:deoplete#enable_at_startup = 1
let g:SuperTabDefaultCompletionType = '<C-X><C-O>'

" YCM
" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'


" YCM Support for Vimtex
" if !exists('g:ycm_semantic_triggers')
"   let g:ycm_semantic_triggers = {}
" endif
" let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
