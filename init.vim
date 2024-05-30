set number
set backspace=indent,eol,start
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
Plug 'dense-analysis/ale'
Plug 'freddiehaddad/feline.nvim'
call plug#end()

lua require('nightfox').load('terafox')
lua require('feline').setup()
lua require('feline').winbar.setup()
lua require('feline').statuscolumn.setup()

colorscheme terafox
