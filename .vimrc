" Set relative number
set relativenumber

" Set <Leader> key to space
let mapleader = " "

" =============================
" Insert Mode Mappings
" =============================

" Exit insert mode by typing 'jk'
inoremap jk <ESC>

" =============================
" Visual Mode Mappings
" =============================

" Exit visual mode with <leader>jk
vnoremap <leader>jk <ESC>

" Move selection down/up and reselect it
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Delete to black hole register (without affecting clipboard)
vnoremap <leader>d "_d
vnoremap <leader>c "_c

" Paste over selection without overwriting clipboard
xnoremap <leader>p "_dP

" Yank to system clipboard
vnoremap <leader>y "+y

" =============================
" Normal Mode Mappings
" =============================

" Join lines without moving the cursor
nnoremap J mzJ`z

" Scroll half page up/down and center cursor
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Delete to black hole register (without affecting clipboard)
nnoremap <leader>d "_d
nnoremap <leader>c "_c

" Yank to system clipboard
nnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" Recenter cursor after searching
nnoremap n nzzzv
nnoremap N Nzzzv

" Indent around a paragraph without moving the cursor
nnoremap =ap ma=ap'a

