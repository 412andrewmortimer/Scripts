" vim interactive mode, use interactive shell
set shellcmdflag=-lic

" Show what command you are typing
set showcmd

" Vundle reqs
"  remove backwards compatibility with vi
set nocompatible

filetype off

" tab completion for command line
set wildchar=<Tab> wildmenu wildmode=full

" Syntax highligting, etc.
filetype plugin on
syntax enable
set grepprg=grep\ -nH\ $*

"
set autoindent

" Tabs to spaces
set expandtab
set smarttab

" two space tab
set shiftwidth=2
set softtabstop=2

" Enable mouse support in console
set mouse=a

"
set backspace=2

" Line numbers
set number

" Remap jj to escape insert mode
inoremap jj <Esc>

nnoremap JJJJ <Nop>

" ruby path if you are using rbenv
let g:ruby_path = system('echo $HOME/.rbenv/shims')

" highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" change leader to ,
let mapleader=","

"remove all trailing whitespace with ,W
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>

" auto load files if vim detects they have been changed outside of Vim
set autoread

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" insert mode, press <F5> for pastetoggle
set pastetoggle=<F5>

" leave paste mode when leaving insert
au InsertLeave * set nopaste

set hlsearch

" vim color scheme bump
set t_Co=256

" make views automatic
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" change present working directory to current file loc
nnoremap ,cd :cd %:p:h<CR>:pwd<CR>

" spell checking, automatic wrapping at 72 columns for git commit message
autocmd Filetype gitcommit setlocal spell textwidth=72

" ease vim access to osx clipboard
set clipboard=unnamed