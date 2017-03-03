" Note that some options were removed because
" neovim has them as default setting

filetype off


set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.config/nvim/dein')
  call dein#begin('~/.config/nvim/dein')
  call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('scrooloose/nerdtree')
  call dein#add('majutsushi/tagbar')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('morhetz/gruvbox')
  call dein#add('bogado/file-line')
  call dein#add('vivien/vim-linux-coding-style')
  call dein#add('roxma/nvim-completion-manager')
  call dein#add('roxma/clang_complete')
  call dein#add('arakashic/chromatica.nvim')
  call dein#add('joshdick/onedark.vim')
  call dein#add('mhinz/vim-janah')
  call dein#add('jsfaint/gen_tags.vim')
  call dein#end()
  call dein#save_state()
endif
filetype plugin indent on
syntax enable




""""""""""""""""""" plugin configs
" only start NERDTree when vim starts without file open
autocmd VimEnter * if !argc() | NERDTree | endif


" chromtica config
let g:chromatica#highlight_feature_level = 1 "more syntax highlight
let g:chromatica#enable_at_startup = 1

" gen_tags autogenerate
let g:gen_tags#gtags_auto_gen = 1

" tagbar
nmap <F8> :TagbarToggle<CR>
" nerdtree
nmap <F7> :NERDTreeToggle<CR>




""""""""""""""""""" general stuff
" Use X clipoboard
set clipboard=unnamedplus

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" a=activate mouse, r=activate copy/pasting from X
set mouse-=a

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
set number
set ruler
set showmatch
set cursorline
set nostartofline





""""""""""""""""""" some UI stuff
" airline config
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
" detect drak/light background
set background=dark
"set termguicolors
colorscheme janah
" spell checking style
hi clear SpellBad
hi SpellBad cterm=underline

set statusline=%<%f%m\ %r\ %h\ %w%=%l,%c\ %p%%
set rulerformat=%27(%{strftime('%a\ %e\ %b\ %I:%M\ %p')}\ %2l,%-2(%c%V%)\ %P%)



""""""""""""""""""" some special stuff and hacks
" Get root privilieges while editing a file
cmap w!! %!sudo tee > /dev/null %

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red
match ExtraWhitespace /\s\+$/


""""""""""""""""""" key mapping
" Buffer keybinds
nnoremap <A-j> :bp<CR>
nnoremap <A-k> :bn<CR>
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
nnoremap <A-q> :bd<CR>

" when pressing r, replace marked section with register
vmap r "_dP

set pastetoggle=<F5>



