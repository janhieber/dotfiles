set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
let g:airline_powerline_fonts = 1
let g:airline_theme='powerlineish'


autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
" Close all open buffers on entering a window if the only
" buffer that's left is the NERDTree buffer
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction

autocmd VimEnter * NERDTree     "Open by default
autocmd VimEnter * wincmd p     "Set Coursour to right window

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'



" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" set leader key
let mapleader=","

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>















" Syntax highlighting
syntax on

" Detect drak/light background
set background=dark

" Color scheme
colorscheme solarized

" a=activate mouse, r=activate copy/pasting from X
set mouse=r

" Show line numbers
set number

" Display cursor position
set ruler

" Ruler formatting
set rulerformat=%27(%{strftime('%a\ %e\ %b\ %I:%M\ %p')}\ %2l,%-2(%c%V%)\ %P%)

" Show matching parenthesis
set showmatch

" Detect filetype for indentation
if has("autocmd")
  filetype indent on
endif

" Restore cursor position when reopening file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" Only research containing a capital letter is case sensitive
set smartcase

" Not case sensitive
set ignorecase

" Highlight all search results
set hlsearch

" Wrap search
set wrapscan

" Live search
set incsearch

" Preserve indentation
set preserveindent

" Let plugins handle indentation
set autoindent
filetype plugin indent on
filetype indent on

" Indentation width
set shiftwidth=2

" Round the indentation width
set shiftround

" Tab width
set tabstop=2

" Tab key width
set softtabstop=2

" Replace tabs with spaces
set expandtab

" Use shiftwidth instead of tabstop at the beggining of the line
set smarttab

" Switch paste mode on/off
set pastetoggle=<F5>

" Always keep X visible lines before/after the cursor
set scrolloff=5

" Make scripts executable
function ModeChange()
  if getline(1) =~ "^#!"
    if getline(1) =~ "/bin/"
      silent !chmod a+x <afile>
    endif
  endif
endfunction

au BufWritePost * call ModeChange()

" Always display the status bar
set laststatus=2

" Status bar format
set statusline=%<%f%m\ %r\ %h\ %w%=%l,%c\ %p%%

" Always activate the backspace key
set backspace=2

" Get to the next line when hitting "right" at the end of the line
set whichwrap=<,>,[,]

" Always stay on the same column
set nostartofline

" Get root privilieges while editing a file
cmap w!! %!sudo tee > /dev/null %

