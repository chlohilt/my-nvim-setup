set number
set clipboard+=unnamedplus
set backspace=indent,eol,start
" don't allow arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" Map space+ps to paste latest screenshot
nnoremap <leader>ps :call PasteLatestScreenshot()<CR>
syntax on 

" Set up shell configuration
set shellcmdflag=-c
set shell=/usr/bin/bash
let $TMP="/tmp"

" Set the leader key to space
let mapleader="<space>"
" Map double leader press to source the Vim config file
nnoremap <silent> <Leader><Leader> :source $MYVIMRC<cr>

" ALE SETUP
" Set autocomplete on Ale
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
" Set error sign
let g:ale_sign_error = '✗'
" Set fix on save and keep gutters always visible
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
" Tab key behavior when popup menu (pum) is visible
inoremap <silent><expr><TAB>
    \ pumvisible() ? “\<C-n>” : “\<TAB>”
" Go To Definition and Find Reference mapped to F4 and F8
nmap <silent> <F4> :ALEGoToDefinition<CR>
nmap <silent> <F8> :ALEFindReferences<CR>
" Navigate between errors
nmap <silent> <F3> <Plug>(ale_previous_wrap)
nmap <silent> <F9> <Plug>(ale_next_wrap)
" Enable ALE
let g:ale_linters = {
    \ 'typescript': ['eslint'],
    \ 'yml': ['yamllint'],
\ }

if empty(glob('C:\Users\chloehi\AppData\Local\nvim-data\site\autoload\plug.vim'))
  silent !curl -fLo C:\Users\chloehi\AppData\Local\nvim-data\site\autoload\plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'EdenEast/nightfox.nvim'
Plug 'freddiehaddad/feline.nvim'
Plug 'dense-analysis/ale'
call plug#end()

lua require('nightfox').load('terafox')
lua require('feline').setup()
lua require('feline').winbar.setup()
lua require('feline').statuscolumn.setup()

colorscheme terafox
