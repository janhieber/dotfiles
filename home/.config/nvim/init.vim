set nocompatible
filetype off
set shell=bash

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#rc("~/.config/nvim/bundle/")

" Bundles
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-fugitive'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'kchmck/vim-coffee-script'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-scripts/SyntaxRange'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'tpope/vim-dispatch'
Plugin 'kien/ctrlp.vim'
Plugin 'cespare/vim-toml'
Plugin 'rust-lang/rust.vim'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'zah/nim.vim'
" /Bundles

filetype plugin indent on

set laststatus=2
set t_Co=256
" Configure airline to look pretty
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_linecolumn_prefix = '␊ '
let g:airline_linecolumn_prefix = '␤ '
let g:airline_linecolumn_prefix = '¶ '
let g:airline#extensions#branch#symbol = '⎇ '
let g:airline#extensions#paste#symbol = 'ρ'
let g:airline#extensions#paste#symbol = 'Þ'
let g:airline#extensions#paste#symbol = '∥'
let g:airline#extensions#whitespace#symbol = 'Ξ'

let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1

set encoding=utf-8
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set magic " unbreak vim's regex implementation

set number
set relativenumber
set scrolloff=3

set ttyfast
set ruler
set nowrap

set ignorecase
set smartcase

" Search as you type, highlight results
set incsearch
set showmatch
set hlsearch

" Resize windows and move tabs and such with the mouse
set mouse=a

" Don't litter swp files everywhere
set backupdir=~/.cache/.backup
set directory=~/.cache/.backup

syntax on
let mapleader = "\<space>"
nnoremap \\ :noh<cr> " Clear higlighting
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR> " Trim trailing spaces
nnoremap cc :center<cr>
nnoremap <tab> %
vnoremap <tab> %
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>
nnoremap <leader>ft Vatzf " Reselect pasted text
inoremap <C-c> <ESC>
inoremap <C-c>h 4h4x
cmap w!! %!sudo tee > /dev/null % " use w!! to write file as root

" Various file formats
autocmd FileType c setlocal noet ts=4 sw=4
autocmd FileType h setlocal noet ts=4 sw=4
autocmd FileType s setlocal noet ts=4 sw=4
autocmd FileType go setlocal noet ts=4 sw=4
autocmd FileType hy setlocal set filetype=lisp

" Printer
let &printexpr="(v:cmdarg=='' ? ".
    \"system('lpr' . (&printdevice == '' ? '' : ' -P' . &printdevice)".
    \". ' ' . v:fname_in) . delete(v:fname_in) + v:shell_error".
    \" : system('mv '.v:fname_in.' '.v:cmdarg) + v:shell_error)"
set printoptions=formfeed:y

hi Search ctermbg=12
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=e

"let g:nerdtree_tabs_open_on_gui_startup = 1

nmap <leader>l :set list!<CR>
set listchars=tab:▸\ ,eol:¬
highlight NonText ctermfg=darkgrey
highlight SpecialKey ctermfg=darkgrey
highlight clear SignColumn
highlight Comment cterm=italic ctermfg=darkgrey
syntax enable

" Transparent editing of gpg encrypted files.
" By Wouter Hanegraaff
augroup encrypted
  au!

  " First make sure nothing is written to ~/.viminfo while editing
  " an encrypted file.
  autocmd BufReadPre,FileReadPre *.gpg set viminfo=
  " We don't want a various options which write unencrypted data to disk
  autocmd BufReadPre,FileReadPre *.gpg set noswapfile noundofile nobackup

  " Switch to binary mode to read the encrypted file
  autocmd BufReadPre,FileReadPre *.gpg set bin
  autocmd BufReadPre,FileReadPre *.gpg let ch_save = &ch|set ch=2
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufReadPost,FileReadPost *.gpg '[,']!gpg --decrypt 2> /dev/null

  " Switch to normal mode for editing
  autocmd BufReadPost,FileReadPost *.gpg set nobin
  autocmd BufReadPost,FileReadPost *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost *.gpg execute ":doautocmd BufReadPost " . expand("%:r")

  " Convert all text to encrypted text before writing
  " (If you use tcsh, you may need to alter this line.)
  autocmd BufWritePre,FileWritePre *.gpg '[,']!gpg --default-recipient-self -ae 2>/dev/null
  " Undo the encryption so we are back in the normal text, directly
  " after the file has been written.
  autocmd BufWritePost,FileWritePost *.gpg u
augroup END

augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile *mutt-*              setfiletype mail

" Support for vim modeline in git config.
let git_config_modeline = system("git config --get vim.modeline")
if strlen(git_config_modeline)
    exe "set" git_config_modeline
endif

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

hi jsParensError ctermbg=NONE

set splitbelow
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']

set hidden
