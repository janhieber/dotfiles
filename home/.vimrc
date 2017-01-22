" Do not use vi compatibility mode
set nocompatible

" Syntax highlighting
syntax on

" Color scheme
colorscheme peachpuff

" Detect drak/light background
set background&

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

