set nu
set rnu

set ts=4
set et

set sw=4
set sr

set sts=4

set tgc
set cursorline
syntax on

set ls=2
set bs=2

set hlsearch
set incsearch

set encoding=utf8
set fileencodings=utf8

let mapleader=" "

nmap <leader>w <C-w>
nmap <leader>e :Ex<CR>
nmap <leader>h :noh<CR>
nmap <leader>c :bd<CR>
nmap <leader>b :ls<CR>
nmap L :bn<CR>
nmap H :bp<CR>

imap ( ()<Esc>i
imap [ []<Esc>i
imap { {}<Esc>i

let g:netrw_banner=0
