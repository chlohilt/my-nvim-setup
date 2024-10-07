set relativenumber
set clipboard+=unnamedplus
set backspace=indent,eol,start
set encoding=UTF-8
" Enable folding
set foldmethod=syntax  " Use syntax-based folding
set foldlevelstart=99  " Start with all folds open
set foldnestmax=10     " Maximum fold depth
set foldenable         " Enable folding
" Set the leader key to space
let mapleader=" "
if has("macunix")
    " You're on a Mac, use zsh as the shell
    set shell=/bin/zsh
elseif has("win32") || has("win64")
    " You're on Windows, use the appropriate shell
    set shell=C:/Program\ Files/Git/bin/bash.exe
endif
set shellcmdflag=-c
set shellquote=\"
set shellxquote=

filetype plugin indent on
" make Backspace work like Delete
set backspace=indent,eol,start

" reload files changed outside of Vim not currently modified in Vim (needs below)
set autoread
" http://stackoverflow.com/questions/2490227/how-does-vims-autoread-work#20418591
au FocusGained,BufEnter * :silent! !

" number of lines above/below when jumping
set scrolloff=5

" set tab in insert mode
imap <Tab> <C-V><Tab>

" Indent new line the same as the preceding line
set autoindent

" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
set autochdir

" don't allow arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Map writing files to Ctrl+s
nnoremap <C-s> <cmd>w<cr>

" Map space+ps to paste latest screenshot
nnoremap <leader>ps :call PasteLatestScreenshot()<CR>
syntax on 

" Set up shell configuration
set shellcmdflag=-c
let $TMP="/tmp"

" Mapping to exit out of terminal with Ctrl+x
tnoremap <C-x> <C-\><C-n>

echo "Loading .vimrc ..."
" Map double leader press to source the Vim config file
nnoremap <silent> <leader><leader> <Cmd>source $MYVIMRC<CR>

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

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
" Use j to navigate down in the popup menu
inoremap <silent><expr> j pumvisible() ? "\<C-n>" : "j"
" Use k to navigate up in the popup menu
inoremap <silent><expr> k pumvisible() ? "\<C-p>" : "k"
" Use TAB to select the top item in the popup menu
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
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

" Gutentags set up 
" define what a "new project" (has package json file and .git file)
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['package.json', '.git']
" move tags and tags lock file so they don't show up in git
let g:gutentags_cache_dir = expand('~/.cache/vim/ctags/')
" configure Gutentags to generate in most cases
let g:gutentags_generate_on_new = 1
let g:gutentags_generate_on_missing = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_empty_buffer = 0
" a=access of class members, i=inheritance info, m=implementation info,
" s=signature of routine
let g:gutentags_ctags_extra_args = [
      \ '--tag-relative=yes',
      \ '--fields=+aimS',
      \ ]

if empty(glob('C:\Users\chloehi\AppData\Local\nvim-data\site\autoload\plug.vim'))
  silent !curl -fLo C:\Users\chloehi\AppData\Local\nvim-data\site\autoload\plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" https://github.com/tpope/vim-commentary for commenting
Plug 'tpope/vim-commentary'
" https://github.com/hrsh7th/nvim-cmp for autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" color scheme
Plug 'EdenEast/nightfox.nvim'
" Plug 'freddiehaddad/feline.nvim'
Plug 'dense-analysis/ale'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
" Plug 'jiangmiao/auto-pairs'
" Gutentags for tag files in Vim (allows for jumping to function definition
" quickly)
Plug 'ludovicchabant/vim-gutentags'
" Plugin for file system explorer
Plug 'preservim/nerdtree'
" Plugin for vim icons
Plug 'ryanoasis/vim-devicons'
call plug#end()

lua require('nightfox').load('terafox')
" lua require('feline').setup()
" lua require('feline').winbar.setup()
" lua require('feline').statuscolumn.setup()

colorscheme terafox
lua <<EOF

local function safe_require(module)
    local success, result = pcall(require, module)
    if not success then
        return nil
    end
    return result
end

local cmp = safe_require('cmp')
if not cmp then
    return
end

local setup_status, setup_error = pcall(function()
    cmp.setup({
        snippet = {
            expand = function(args)
                vim.snippet.expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' }
        }, {
            { name = 'buffer' },
        })
    })
end)

if not setup_status then
    print("Error during cmp.setup:")
    print(setup_error)
end

local lspconfig = safe_require('lspconfig')
local cmp_nvim_lsp = safe_require('cmp_nvim_lsp')

if lspconfig and cmp_nvim_lsp then
    local capabilities = cmp_nvim_lsp.default_capabilities()
    lspconfig['tsserver'].setup {
        capabilities = capabilities
    }
else
    print("lspconfig or cmp_nvim_lsp not loaded, skipping lsp setup")
end

EOF
