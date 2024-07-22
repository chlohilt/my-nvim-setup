set number
set clipboard+=unnamedplus
set backspace=indent,eol,start
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" Map space+ps to paste latest screenshot
nnoremap <leader>ps :call PasteLatestScreenshot()<CR>
syntax on 

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

" Function to paste latest screenshot in MD file (use <leader>ps)
function! PasteLatestScreenshot()
    " Path to the PowerShell script
    let ps_script = 'C:\Users\chloehi\Repos\scripts\save_clipboard_image_vim.ps1'
    
    " Ensure the path is properly escaped
    let ps_script_escaped = substitute(ps_script, ' ', '` ', 'g')
    
    " Execute PowerShell script and get the output
    let cmd = 'powershell -ExecutionPolicy Bypass -File "' . ps_script_escaped . '"'
    let output = system(cmd)
    let lines = split(output, "\n")
    let latest_file = ''

    " Search for the line containing the filename
    for line in lines
        if line =~ '^screenshot_\d\+\.png$'
            let latest_file = line
            break
        endif
    endfor

    if latest_file != ''
        " Path to the screenshot directory (update this path)
        let screenshot_dir = 'C:\Users\chloehi\Documents\Screenshots'
        let current_dir = expand('%:p:h')
        
        " Ensure paths are properly escaped
        let src_path = substitute(screenshot_dir . '\' . latest_file, ' ', '` ', 'g')
        let dest_path = substitute(current_dir . '\' . latest_file, ' ', '` ', 'g')
        
        " Copy the file to the current working directory
        let copy_cmd = 'powershell -Command "Copy-Item -Path \"' . src_path . '\" -Destination \"' . dest_path . '\""'
        let copy_output = system(copy_cmd)
        
        if v:shell_error == 0
            " Insert the markdown image syntax at the cursor
            let markdown_syntax = '![' . latest_file . '](' . latest_file . ')'
            execute "normal! i" . markdown_syntax . "\<Esc>"
            echo "Screenshot inserted: " . latest_file
        else
            echo "Error copying file. Output: " . copy_output
        endif
    else
        echo "Error: No screenshot found. PowerShell output: " . output
        echo "Command executed: " . cmd
    endif
endfunction

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
