"vundle
set nocompatible
filetype off

" Set the default file encoding to UTF-8:
set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8


set rtp+=~/.vim/bundle/Vundle.vim


call plug#begin('~/.vim/plugged')
Plug 'iamcco/mathjax-support-for-mkdp'
Plug 'iamcco/markdown-preview.vim'
call plug#end()

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"git interface
"Plugin 'tpope/vim-fugitive'
"filesystem
"Plugin 'scrooloose/nerdtree'
"Plugin 'jistr/vim-nerdtree-tabs'
"Plugin 'kien/ctrlp.vim'
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim'}
"html
"  isnowfy only compatible with python not python3
"Plugin 'isnowfy/python-vim-instant-markdown'
"Plugin 'jtratner/vim-flavored-markdown'
"Plugin 'suan/vim-instant-markdown'
"Plugin 'nelstrom/vim-markdown-preview'
"Plugin 'JamshedVesuna/Vim-markdown-preview'
"python sytax checker
"Plugin 'nvie/vim-flake8'
"Plugin 'vim-scripts/Pydiction'
"Plugin 'vim-scripts/indentpython.vim'
"Plugin 'scrooloose/syntastic'

"auto-completion stuff
"Plugin 'klen/python-mode'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'klen/rope-vim'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'ervandew/supertab'
""code folding
"Plugin 'tmhedberg/SimpylFold'

"Colors!!!
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'

call vundle#end()

set splitbelow
set splitright
set laststatus=2   "show powerline always
"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"ctrl j  move to split below
"ctrl k above
"ctrl l right
"ctrl h left

autocmd FileType python map <buffer>  <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>

autocmd FileType python imap <buffer>  <F9>  <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>


set clipboard=unnamed

"NERDTree shortcut
map <F2> :NERDTreeToggle<CR>




filetype plugin indent on    " enables filetype detection
let g:SimpylFold_docstring_preview = 1

"autocomplete
let g:ycm_autoclose_preview_window_after_completion=1

"custom keys
let mapleader=" "
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"
"call togglebg#map("<F5>")
"colorscheme zenburn
"set guifont=Monaco:h14

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

"I don't like swap files
set noswapfile

"turn on numbering
set nu

"enable folding
set foldmethod=indent
set foldlevel=99


"python with virtualenv support
py << EOF
import os.path
import sys
import vim
if 'VIRTUA_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  sys.path.insert(0, project_base_dir)
  activate_this = os.path.join(project_base_dir,'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

"it would be nice to set tag files by the active virtualenv here
":set tags=~/mytags "tags for ctags and taglist
"omnicomplete
autocmd FileType python set omnifunc=pythoncomplete#Complete

"------------Start Python PEP 8 stuff----------------
" Number of spaces that a pre-existing tab is equal to.
au BufRead,BufNewFile *py,*pyw,*.c,*.h,*,sh set tabstop=4

"spaces for indents
au BufRead,BufNewFile *.py,*pyw,*,sh set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw,*.sh set expandtab
au BufRead,BufNewFile *.py,*.sh set softtabstop=4

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" Wrap text after a certain number of characters
au BufRead,BufNewFile *.py,*.pyw, set textwidth=100

" Use UNIX (\n) line endings.
au BufNewFile *.py,*.pyw,*.c,*.h set fileformat=unix
" For full syntax highlighting:
let python_highlight_all=1
syntax on

" Keep indentation level from previous line:
autocmd FileType python set autoindent

" make backspaces more powerfull
set backspace=indent,eol,start

" for normal mode
nmap <silent> <F8> <Plug>MarkdownPreview
" for insert mode
imap <silent> <F8> <Plug>MarkdownPreview
" for normal mode
nmap <silent> <F9> <Plug>StopMarkdownPreview
" for insert mode
imap <silent> <F9> <Plug>StopMarkdownPreview


"Folding based on indentation:
autocmd FileType python set foldmethod=indent
"use space to open folds
nnoremap <space> za 
"----------Stop python PEP 8 stuff--------------

"js stuff"
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
