" -- PLUGINS --

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-sensible'
Bundle 'altercation/vim-colors-solarized'
Bundle 'wincent/Command-T'
Bundle 'vim-scripts/LustyJuggler'
Bundle 'scrooloose/syntastic'
Bundle 'vim-scripts/AutoTag'


" -- FONT AND COLORS --

set gfn=ProggyCleanTTSZ\ 12

set background=dark
colorscheme solarized


" -- GUI --

if has("gui_running")
    " Maximize window
    set lines=999 columns=999
    " Remove toolbar
    set guioptions-=T
    " Remove menu bar
    set guioptions-=m
    " Remove right-hand scroll bar
    set guioptions-=r
    " Remove left-hand scroll bar
    set guioptions-=l
    " Remove bottom scroll bar
    set guioptions-=b
endif


" -- KEYBOARD MAPPINGS --

let mapleader = "ä"

set pastetoggle=<F2>

" Learn it the hard way
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Go to next row instead of line
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Enter command mode made easier when using a swedish keyboard
noremap ö :
" Edit .vimrc
nmap <silent> <leader>ec :e $MYVIMRC<CR>
" Reload .vimrc
nmap <silent> <leader>rc :so $MYVIMRC<CR>
" Fast saving
nmap <leader>w :w!<CR>
" Close all the buffers
map <leader>bd :1,1000 bd!<CR>
" Clear the current seach highlight
nmap <silent> ä/ :nohlsearch<CR>
" Go to tag
nmap <leader>g <C-]>
" Go back from tag
nmap <leader>f <C-t>
" End of line made easier when using a Swedish keyboard
nnoremap ¤ $
" Use beginning of words rather than begining of line
noremap 0 ^
" Enter a new line after the cursor without going into insert mode
nmap <CR> o<Esc>
" Enter a new line before the cursor without going into insert mode
nmap <S-Enter> O<Esc>
" Move to the next row instead of next line
nmap j gj
nmap k gk
" Show bufffers in Lusty Juggler
nmap å <leader>lj
" Toggle Syntastic syntax checker
map <silent> <leader>sc :SyntasticToggleMode<CR>
" Re-indent containing block and braces
map <leader>ib =a{
" Exit insert mode easier when using a Swedish keyboard
inoremap öö <Esc>
" Paste on a new line
nmap <silent> <leader>p :pu<CR>


" -- EDITOR --

" No mouse of cource
set mouse=

" Don't wrap lines
set nowrap
" Use spaces instead of tabs
set expandtab
" The number of spaces used for tab
set tabstop=4
" The number of spaces used for autoindention
set shiftwidth=4
" Show line numbers
set number
" Line length
set tw=120

" Highlight search terms
set hlsearch
" Ignore case when searching
set ignorecase
" Ignore case if search pattern is all lowercase,
set smartcase

" Remember more commands and search history
set history=1000
" Use many levels of undo
set undolevels=1000

" Ignore binary and temp files when using tab completion
set wildignore=*.swp,*.bak,*.pyc,*.class

" Show tabs, trailing white space and end lines with #
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
" Ignore tabs in HTML and XML files
autocmd filetype html,xml set listchars-=tab:>.


" -- BUFFERS --

" Hide buffers insead of closing them when switching
set hidden

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%


" -- COPY AND PASTE --

" Make the PRIMARY clipboard default
set clipboard=unnamedplus


" -- SAVE AND BACKUP --

set nobackup
set noswapfile
command W w !sudo tee % > /dev/null


" -- HELPER FUCTIONS --

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()
