" Note that some options were removed because
" neovim has them as default setting

filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/nerdtree'
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'ryanoasis/vim-devicons'
Plugin 'rdnetto/YCM-Generator'
Plugin 'morhetz/gruvbox'
Plugin 'bogado/file-line'
Plugin 'vivien/vim-linux-coding-style'
call vundle#end()

filetype plugin indent on

" install with
" :PluginInsall

" update with
" :PluginUpdate

" in neovim do this after install/update
" :UpdateRemotePlugins



""""""""""""""""""" plugin configs
" only start NERDTree when vim starts without file open
autocmd VimEnter * if !argc() | NERDTree | endif

" YouCompleteMe default config
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" close nerdtree if nothing else left
autocmd WinEnter * call s:CloseIfOnlyNerdTreeLeft()
function! s:CloseIfOnlyNerdTreeLeft()
  if exists("t:NERDTreeBufName")
    if bufwinnr(t:NERDTreeBufName) != -1
      if winnr("$") == 1
        q
      endif
    endif
  endif
endfunction




""""""""""""""""""" general stuff
" Use X clipoboard
set clipboard=unnamedplus

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" a=activate mouse, r=activate copy/pasting from X
set mouse-=a

set number
set ruler
set showmatch
set cursorline

" Detect filetype for indentation
"if has("autocmd")
"  filetype indent on
"endif

" Restore cursor position when reopening file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

set smartcase
set ignorecase
set wrapscan

set preserveindent
set shiftwidth=2
set shiftround
set tabstop=2
set softtabstop=2
set expandtab
set scrolloff=5

" Get to the next line when hitting "right" at the end of the line
"set whichwrap=<,>,[,]

" Always stay on the same column
set nostartofline




""""""""""""""""""" some UI stuff
" airline config
let g:airline_powerline_fonts = 1
let g:airline_theme='gruvbox'
" enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" detect drak/light background
set background=dark
" color scheme
let g:gruvbox_italic=1
colorscheme gruvbox
" Status bar format
set statusline=%<%f%m\ %r\ %h\ %w%=%l,%c\ %p%%
" Ruler formatting
set rulerformat=%27(%{strftime('%a\ %e\ %b\ %I:%M\ %p')}\ %2l,%-2(%c%V%)\ %P%)




""""""""""""""""""" some special stuff and hacks
" Get root privilieges while editing a file
cmap w!! %!sudo tee > /dev/null %

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/




""""""""""""""""""" key mapping
" Buffer keybinds
nnoremap <A-j> :bp<CR>
nnoremap <A-Left> :bp<CR>
nnoremap <A-k> :bn<CR>
nnoremap <A-Right> :bn<CR>
nnoremap <A-g> :e#<CR>
nnoremap <A-1> :1b<CR>
nnoremap <A-2> :2b<CR>
nnoremap <A-3> :3b<CR>
nnoremap <A-4> :4b<CR>
nnoremap <A-5> :5b<CR>
nnoremap <A-6> :6b<CR>
nnoremap <A-7> :7b<CR>
nnoremap <A-8> :8b<CR>
nnoremap <A-9> :9b<CR>
" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nnoremap <A-q> :bp<BAR> bd #<CR>

" when pressing r, replace marked section with register
vmap r "_dP

set pastetoggle=<F5>
nmap <F8> :TagbarToggle<CR>
nmap <F7> :NERDTreeToggle<CR>


