" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')

function! SetColorscheme(...)
    try
        colorscheme Tomorrow-Night
    catch /^Vim\%((\a\+)\)\=:E185/
        autocmd VimEnter * echom "Color scheme not found. Maybe it's installing?"
    endtry
endfunction

" Add all your plugs here 
Plug 'w0rp/ale' " Linting
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --js-completer --java-completer' } " Compiled locally, currently without c support
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/nerdtree' " File tree
Plug 'kien/ctrlp.vim' " Search files and tags from vim
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim/', 'do': function('SetColorscheme') }
Plug 'mileszs/ack.vim' " Code searching using ack, like ':Ack test'
Plug 'airblade/vim-gitgutter' " Shows git diffs
Plug 'leafgarland/typescript-vim' " Typescript syntax support

" Initialize plugin system
call plug#end()
" Remember, install new plugins using :PlugInstall


" These settings are for ale, which adds syntax linting to vim
silent! helptags ALL
nmap <leader>at :ALEToggle<CR>

" Custom vim settings
set backspace=2 " backspace over everything in insert mode
set tabstop=4 " tab size
set shiftwidth=4 " with python, allows using < and > keys in visual mode to block indent/unindent regions
set expandtab " insert spaces in place of tabs
set softtabstop=4 " makes vim see 4 spaces as a tab when backspacing
set smarttab " use shiftwidth instead of tabstop at the beginning of a line
set autoindent " matches indentation of new line to previous
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 " set tab size for js files
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 " set tab size for js files

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

" Enable line numbering
set nu

" Set default colorscheme to fix indent-guides
colorscheme Tomorrow-Night
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=238
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236

" NERDtree file tree settings
nmap <leader>nt :NERDTreeToggle<CR>
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore = ['\.pyc$', '__pycache__']

" json and xml formatting shortcuts
nmap fx :%!xmllint --format --recover -<CR>
" nmap fj :%!jq .<CR>
nmap fj :%!python -m json.tool <CR> 
" viminfo settings
set viminfo='100,<200,s10,h,<200 " increase number of lines that can be yanked between vim sessions

" YouCompleteMe settings
let g:ycm_python_binary_path='/usr/local/bin/python3' " make sure we use python3 completion

" ctrlp settings
let g:ctrlp_cache_dir=$HOME . '/.cache/ctrlp' " configures the cache location
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""' " use silver surfer to search for files
endif
