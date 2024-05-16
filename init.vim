set number

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
call plug#end()

lua require('nightfox').load('terafox')

colorscheme terafox
