set number
set clipboard+=unnamedplus
set backspace=indent,eol,start

" Set the leader key to space
let mapleader=" "
" Map double leader press to source the Vim config file
nnoremap <silent> <Leader><Leader> :source $MYVIMRC<cr>

if empty(glob('C:\Users\chloehi\AppData\Local\nvim-data\site\autoload\plug.vim'))
  silent !curl -fLo C:\Users\chloehi\AppData\Local\nvim-data\site\autoload\plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.3', 'do': 'make install_jsregexp'}
Plug 'hrsh7th/cmp-path'
Plug 'EdenEast/nightfox.nvim'
Plug 'freddiehaddad/feline.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }
call plug#end()

lua require('nightfox').load('terafox')
lua require('feline').setup()
lua require('feline').winbar.setup()
lua require('feline').statuscolumn.setup()

colorscheme terafox
