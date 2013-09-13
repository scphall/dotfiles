""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sam Hall's .vimrc file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

" Basics
set number
set autoindent
set smartindent
set expandtab
set cpoptions+=$
set hlsearch
set wildmenu
set tabstop=2
set shiftwidth=2
set encoding=utf8
" set cursorline " Too slow on my little laptop
set guicursor=n:blinkon0
set list
set listchars=tab:▸\ ,
set listchars=eol:↵
let mapleader = ","
filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins
filetype plugin indent on
syntax on

" remove trailing whitespace on save
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor
  " position
  let @/=_s
  call cursor(l, c)
endfunction
" Remove whitespace on save
autocmd BufWritePre * :call Preserve('%s/\s\+$//e')
" insert colon at the end of a line
inoremap <S-Enter> <Esc>:call Preserve('s/\s*$/;/')<Enter>a


" Replace last search
nnoremap <Leader>s :%s///gc<Left><Left><Left>
vnoremap <Leader>s :s///gc<Left><Left><Left>

set tabpagemax=30
set backspace=indent,eol,start


" Tab settings for individual filetypes
function! Tabglobal(numspaces)
    let &tabstop=a:numspaces
    let &shiftwidth=a:numspaces
endfunction

function! Tablocal(numspaces)
    let &l:tabstop=a:numspaces
    let &l:shiftwidth=a:numspaces
endfunction

" Make vim jump to last position upon reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

" Navigation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keep a few screen lines around the cursor
set scrolloff=15
" Disable arrows and page{up,down}
no h h
no k k
no l l
no j j
no <c-u> <c-u>
no <c-d> <c-d>
no n n
no N N
no G G
no <left> <nop>
no <right> <nop>
no <up> ddkP
no <down> ddp
ino <left> <nop>
ino <right> <nop>
ino <up> <nop>
ino <down> <nop>
vno <left> <nop>
vno <right> <nop>
vno <up> <nop>
vno <down> <nop>
no <pageup> <nop>
no <pagedown> <nop>
ino <pageup> <nop>
ino <pagedown> <nop>
vno <pageup> <nop>
vno <pagedown> <nop>

" Basic and important shortcuts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>w :w<CR>
"map <BS> i<BS>
imap <C-v> <Esc>l<C-v>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
vmap <C-f> :fold<CR>
map <leader>tn :tabnext<CR>
map <leader>tp :tabprevious<CR>
map <leader>to :tabnew<CR>
map <leader>fmi :set foldmethod=indent<cr>
map <leader>fms :set foldmethod=syntax<cr>
" this removes hilighting
map <F9> /Hello Sam. <CR>
" Toggle spelling and pastemode
map <leader><leader>ss :setlocal spell!<cr>
map <leader>p :setlocal paste!<CR>:setlocal number!<CR>

" Annoying mistyped comands
command! Q q
command! WQ wq
command! Wq wq
cnoreabbrev q1 q!<CR>
cnoreabbrev Q1 q!<CR>

" Cunning pal to paste consecutive numbers in column
map + yyp<C-A>
" Fast editing of vimrc
map <leader>e :w<CR>:tabnew<CR>:e ~/.vimrc<CR>
autocmd! bufwritepost vimrc source ~/.vimrc

" Brackets
imap <leader>( ()<esc>i
imap <leader>[ []<esc>i
imap <leader>{ {}<esc>i

" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
" Colorschemes
Bundle 'Lokaltog/vim-easymotion'
Bundle 'scrooloose/nerdtree'
Bundle 'Lokaltog/vim-powerline'
Bundle 'Lokaltog/powerline-fonts'
Bundle 'tpope/vim-surround'
Bundle 'sjl/badwolf'
Bundle 'tomasr/molokai'
Bundle 'Lokaltog/vim-distinguished'
Bundle 'tpope/vim-vividchalk'
Bundle 'morhetz/gruvbox'
Bundle 'ervandew/supertab'
Bundle 'kevinw/pyflakes-vim'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'rhysd/open-pdf.vim'
"Bundle 'xolox/vim-easytags'
"Bundle 'xolox/vim-misc'

"Bundle 'flazz/vim-colorschemes' " All the colorschemes
"Bundle 'scrooloose/syntastic' " Pain with cpp
"Bundle 'biskark/vim-ultimate-colorscheme-utility'

" For move  - disables because key bindings don't work except with C
Bundle 'matze/vim-move'
"let g:move_map_keys = 1
"let g:move_key_modifier = 'C'


" Color scheme and visual stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256
colorscheme molokai
set laststatus=2  " Statusline

" Make visual mode a bit easier to see on my screen!
"hi VisualNOS                     guibg=#757475
"hi Visual                        guibg=#757475

let g:syntastic_quiet_warnings=1
let g:syntastic_check_on_wq=0

" Must install powerline-fonts
let g:Powerline_symbols = 'fancy'

let g:pyflakes_use_quickfix = 0

" make txt different colour 80->85 chars
highlight rightMargin ctermfg=magenta
match rightmargin /\%<86v.\%>81v/

map <leader>nt :NERDTreeToggle<cr>

" fsr, this doesn't work in pymaps.vim
"let python_highlight_all = 1
let python_highlight_numbers = 1
let python_highlight_builtins = 1
let python_highlight_exceptions = 1
let python_highlight_space_errors = 1
"let c_no_curly_error = 1

" Fill rest of line with characters
function! FillLine( str )
  " set tw to the desired total length
  let tw = &textwidth
  if tw==0 | let tw = 81 | endif
  " strip trailing spaces first
  .s/[[:space:]]*$//
  " calculate total number of 'str's to insert
  let reps = (tw - col("$")) / len(a:str)
  " insert them, if there's room, removing trailing spaces
  " (though forcing there to be one)
  if reps > 0
    .s/$/\=(''.repeat(a:str, reps))/
  endif
endfunction

" Source other vim files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source $HOME/.vim/abbs.vim
autocmd FileType cpp source $HOME/.vim/cmaps.vim
autocmd FileType cc source $HOME/.vim/cmaps.vim
autocmd FileType c source $HOME/.vim/cmaps.vim
autocmd FileType python source $HOME/.vim/pymaps.vim
autocmd FileType hpp source $HOME/.vim/cmaps.vim
autocmd FileType h source $HOME/.vim/cmaps.vim
autocmd BufNewFile,BufRead *.tex source $HOME/.vim/texmaps.vim
autocmd BufNewFile,BufRead Makefile set noexpandtab
autocmd BufNewFile,BufRead *.sh source $HOME/.vim/bashmaps.vim

" ignore '.DS_Store', '*.pyc' and '*.pyo' files in directory listings
let g:netrw_list_hide='\v(\.DS_Store)|(.*\.py[co])|(\.swp)|(\.nav)|(\.aux)$'


