set number
set clipboard+=unnamedplus
set backspace=indent,eol,start
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Set the leader key to space
let mapleader=" "
" Map double leader press to source the Vim config file
nnoremap <silent> <Leader><Leader> :source $MYVIMRC<cr>

" ALE SETUP
" Set autocomplete on Ale
set omnifunc=ale#completion#OmniFunc
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
" Set fix on save and keep gutters always visible
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
" Tab key behavior when popup menu (pum) is visible
inoremap <silent><expr><TAB>
    \ pumvisible() ? “\<C-n>” : “\<TAB>”
" Go To Definition and Find Reference mapped to F12 and F24
nmap <silent> <F4> :ALEGoToDefinition<CR>
nmap <silent> <F8> :ALEFindReferences<CR>
" Navigate between errors
nmap <silent> <F3> <Plug>(ale_previous_wrap)
nmap <silent> <F9> <Plug>(ale_next_wrap)

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
Plug 'dense-analysis/ale'
call plug#end()

lua require('nightfox').load('terafox')
lua require('feline').setup()
lua require('feline').winbar.setup()
lua require('feline').statuscolumn.setup()

colorscheme terafox
