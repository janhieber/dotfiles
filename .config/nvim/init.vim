" Note that some options were removed because
" neovim has them as default setting

filetype off


set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.config/nvim/dein')
  call dein#begin('~/.config/nvim/dein')
  call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')
  " UI style/theme
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('arcticicestudio/nord-vim')
  " UI enhancement
  call dein#add('scrooloose/nerdtree')
  call dein#add('majutsushi/tagbar')
  " usability improvement
  call dein#add('bogado/file-line')
  call dein#add('qpkorr/vim-bufkill')
  " programming support
  call dein#add('jsfaint/gen_tags.vim')
  call dein#add('rhysd/vim-clang-format')
  call dein#add('vim-scripts/DoxygenToolkit.vim')
  call dein#add('lervag/vimtex')
  call dein#add('mzlogin/vim-markdown-toc')
  call dein#add('rust-lang/rust.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('zchee/deoplete-clang')
  call dein#add('zchee/deoplete-jedi')
  call dein#add('sebastianmarkow/deoplete-rust')
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  " other useful
  call dein#add('sheerun/vim-polyglot')
  call dein#add('tpope/vim-fugitive')
  call dein#end()
  call dein#save_state()
endif
filetype plugin indent on
syntax enable

" :call dein#install()
" :call dein#update()
" :UpdateRemotePlugins


""""""""""""""""""" some UI stuff
" detect drak/light background
set background=dark
"set termguicolors
colorscheme nord


highlight Pmenu ctermfg=black ctermbg=darkcyan
highlight PmenuSel ctermfg=white ctermbg=darkcyan


" spell checking style
hi clear SpellBad
hi SpellBad cterm=underline

set statusline=%<%f%m\ %r\ %h\ %w%=%l,%c\ %p%%
set rulerformat=%27(%{strftime('%a\ %e\ %b\ %I:%M\ %p')}\ %2l,%-2(%c%V%)\ %P%)





""""""""""""""""""" plugin configs
" only start NERDTree when vim starts without file open
autocmd VimEnter * if !argc() | NERDTree | endif


" airline config
let g:airline_powerline_fonts = 1
let g:airline_theme='nord'
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#fnamemod = ':.'
let g:airline#extensions#tabline#fnamecollapse = 1
"let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" chromtica config
let g:chromatica#highlight_feature_level = 1 "more syntax highlight
let g:chromatica#enable_at_startup = 0

" gen_tags autogenerate
let g:gen_tags#gtags_auto_gen = 1

" tagbar
nmap <F8> :TagbarToggle<CR>

" nerdtree
nmap <F7> :NERDTreeToggle<CR>

" clang-format
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11",
            \ "BreakBeforeBraces" : "Stroustrup",
            \ "IndentWidth" : 4}


" Use deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 1
set completeopt-=preview
let g:deoplete#sources#clang#executable = "/usr/bin/clang"
let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
let g:deoplete#sources#clang#clang_header = "/usr/lib/clang/"

let g:deoplete#sources#rust#racer_binary='/usr/bin/racer'
let g:deoplete#sources#rust#rust_source_path='/usr/src/rust/src/'


imap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" neosnippet
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'
imap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)

" vimtex
let g:tex_flavor = 'latex'

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
set shiftwidth=4
set tabstop=4
set expandtab
set scrolloff=10
set softtabstop=4
set number
set ruler
set showmatch
set cursorline
set nostartofline
set textwidth=100


""""""""""""""""""" some special stuff and hacks

" move lines up and down with Alt+j/k
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>

" Get root privilieges while editing a file
cmap w!! %!sudo tee > /dev/null %


" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red
match ExtraWhitespace /\s\+$/

" fix del key in st opening help, we don't need F1
map <F1> <del>
map! <F1> <del>

function! CloseOnLast()
    let cnt = 0
    for i in range(0, bufnr("$"))
        if buflisted(i)
            let cnt += 1
        endif
    endfor
    if cnt <= 1
        wq
    else
        w
        BD
    endif
endfunction
nnoremap ZZ :call CloseOnLast()<CR>


""""""""""""""""""" key mapping
" Buffer keybinds
nnoremap <SPACE> <Nop>
let mapleader=" "
nnoremap <A-h> :bp<CR>
nnoremap <Leader><Left> :bp<CR>
nnoremap <A-l> :bn<CR>
nnoremap <Leader><Right> :bn<CR>
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
nnoremap <A-q> :BD<CR>

"nnoremap ZZ :w<CR>:BD<CR>

" when pressing r, replace marked section with register
vmap r "_dP

set pastetoggle=<F5>


