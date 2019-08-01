" VIM Configuration File
" Description: Optimized for C/C++ development, but useful also for other things.
" Author: Gerhard Gappmeier
"

call plug#begin('~/.vim/plugged')
Plug 'ludovicchabant/vim-gutentags'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
""Plug 'itchyny/lightline.vim'
Plug 'vim-airline/vim-airline'
Plug 'ap/vim-buftabline'
Plug 'editorconfig/editorconfig-vim'
"Plug 'leafgarland/typescript-vim'
"Plug 'quramy/tsuquyomi'
Plug 'HerringtonDarkholme/yats.vim'
"Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" For async completion
"Plug 'Shougo/deoplete.nvim'
Plug 'Valloric/YouCompleteMe',  { 'do': './install.py --clang-completer --clangd-completer --ts-completer' }
"Plug 'autozimu/LanguageClient-neovim', {  'branch': 'next',  'do': 'bash install.sh'  }
Plug 'Quramy/vim-js-pretty-template'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'morhetz/gruvbox'
""Plug 'jiangmiao/auto-pairs'
"Plug 'vim-syntastic/syntastic'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'altercation/vim-colors-solarized'
""Plug 'prettier/vim-prettier', { 'do': 'npm install' }
";Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'f4t-t0ny/nerdtree-hg-plugin'
Plug 'w0rp/ale'
Plug 'jpalardy/vim-slime'
""Plug 'Maximbaz/lightline-ale'
""Plug 'kien/ctrlp.vim'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tomasiser/vim-code-dark'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'phleet/vim-mercenary'
Plug 'tpope/vim-fugitive'
Plug 'ludovicchabant/vim-lawrencium'
"Plug 'kien/rainbow_parentheses.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'vim-scripts/a.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'vim-scripts/OmniCppComplete'
Plug 'Chiel92/vim-autoformat'
call plug#end()




" set UTF-8 encoding
let g:gutentags_ctags_extra_args=["--c++-kinds=+p --fields=+iaS --extra=+q"]
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
set hidden
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
set smarttab
set wrap
" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=120
" turn syntax highlighting on
set t_Co=256
syntax on
" colorscheme wombat256
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
set autoread
set so=7
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set showmatch
set mat=2
set showcmd
set background=dark
set wildmenu
set wildignorecase
set diffopt+=vertical
set cul
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=2
set ttyfast

let isremote = system("df -P -T $PWD | grep fuse ")
if !empty(isremote)
    let g:airline#extensions#disable_rtp_load = 1
    let g:airline_extensions = []
endif
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --no-messages --color "always" '.shellescape(<q-args>), 1, <bang>0)

command Occ :execute 'Find ' .expand('<cword>')
"set cscopetag


"specific nvim"
if has('nvim')
    set termguicolors
    let g:gruvbox_italic=1
endif


"let g:LanguageClient_serverCommands = {
"  \ 'cpp': ['clangd'],
"  \ }
"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>



" to avoid ESC delay with lightline
set timeoutlen=1000 ttimeoutlen=0


" key mappings
"inoremap kj <esc>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> <c-p> :Files<CR>
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>  <Paste>
nmap <F2> :Occ<CR>
nmap <F3> :Find<CR>
nmap <F5> :NERDTreeFind<CR>
nmap <F6> :NERDTreeToggle<CR>
nnoremap Y :YcmCompleter<Space>



if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if has("autocmd")
    filetype plugin indent on
endif

" NERDTree config
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeWinSize=50


au BufRead,BufNewFile *.ts   setfiletype typescript
" Syntastic Config
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:tsuquyomi_disable_quickfix = 1
"let g:syntastic_typescript_checkers = ['tsuquyomi']


" typescript-vim config


" js-pretty-template settings
autocmd FileType typescript JsPreTmpl
"autocmd FileType typescript syn clear foldBraces " For leafgarland/typescript-vim users only. Please see #1 for details.



" tsuquyomi settings
" let g:tsuquyomi_use_vimproc = 1
"
" nvim-typescript
let g:nvim_typescript#default_mappings = 1
let g:nvim_typescript#diagnostics_enable = 0 " I use YCM to show diagnostics

" lightline settings
""set laststatus=2
set noshowmode

"theme settings
let g:gruvbox_contrast_dark = 'medium'
"let g:solarized_termcolors=256
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE


""colorscheme solarized


"Prettier settings"
"
""let g:prettier#exec_cmd_async = 1
""let g:prettier#quickfix_enabled = 0
""""
""let g:prettier#autoformat = 0
"""autocmd BufWritePre,TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
""let g:prettier#config#parser = 'babylon'



"Settings for ALE
let g:ale_linters = {'python':['pylint'],'typescript':['tslint'] , 'cpp':['cppcheck']}
let g:ale_fixers = {'python':['autopep8'],'html':['prettier'], 'scss': ['prettier'] , 'typescript': ['prettier'],'json': ['prettier']}
let g:ale_fix_on_save = 1
highlight link ALEErrorSign ALEWarningSign



"Settings for lightline-ale"
""let g:lightline = {}
""
""let g:lightline.component_expand = {
""      \  'linter_checking': 'lightline#ale#checking',
""      \  'linter_warnings': 'lightline#ale#warnings',
""      \  'linter_errors': 'lightline#ale#errors',
""      \  'linter_ok': 'lightline#ale#ok',
""      \ }
""let g:lightline.component_type = {
""      \     'linter_checking': 'left',
""      \     'linter_warnings': 'warning',
""      \     'linter_errors': 'error',
""      \     'linter_ok': 'left',
""      \ }
""let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]] }
""
""
""
" settings for ctrlp"
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'



" Settings fpr cpp-enhanced"
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1

" Settings for indentguides"
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1


" Settings for airline"
let g:airline_powerline_fonts = 1


"settings for ycm
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_use_clangd = 1
"let g:ycm_clangd_uses_ycmd_caching = 0
let g:ycm_clangd_binary_path = exepath("clangd")
"let g:ycm_use_clangd_args=
"let g:ycm_server_log_level = 'debug'
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:ycm_enable_diagnostic_signs = 1
if has("autocmd")
    filetype on
    autocmd FileType typescript nnoremap <C-]> :YcmCompleter GoTo<CR>
endif

"settings for ultisnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


"settings for gitgutter"
"let g:gitgutter_terminal_reports_focus=0


"settings for vim slime
let g:slime_target = "tmux"
let g:slime_python_ipython = 1


"settings for rainbow
au VimEnter * RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']'],['{','}']]

"settings for signify
let g:signify_vcs_list = [ 'git', 'hg' ]


"settings for ctrlp
"set wildignore+=*node_modules/*,*.so,*.swp,*.zip


"settings to keep session
"function! MakeSession()
"  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
"  if (filewritable(b:sessiondir) != 2)
"    exe 'silent !mkdir -p ' b:sessiondir
"    redraw!
"  endif
"  let b:filename = b:sessiondir . '/session.vim'
"  exe "mksession! " . b:filename
"endfunction
"
"function! LoadSession()
"  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
"  let b:sessionfile = b:sessiondir . "/session.vim"
"  if (filereadable(b:sessionfile))
"    exe 'source ' b:sessionfile
"  else
"    echo "No session loaded."
"  endif
"endfunction
"au VimEnter * nested :call LoadSession()
"au VimLeave * :call MakeSession()

function! LoadCscope()
    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " suppress 'duplicate connection' error
        exe "cs add " . db . " " . path
        set cscopeverbose
        " else add the database pointed to by environment variable
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif
endfunction
au BufEnter /* call LoadCscope()

" autoformat settings
if !empty(isremote)
let g:formatdef_amadeus_format =  '"astyle -A10 --indent=spaces=4 --indent-classes --indent-cases --indent-switches --convert-tabs --indent-col1-comments --add-brackets --max-instatement-indent=120 --min-conditional-indent=0 --pad-oper --pad-comma --pad-header --unpad-paren --align-pointer=type --align-reference=type --preserve-date -n  --lineend=linux --formatted"'
    let g:formatters_cpp = ['amadeus_format']
    au BufWrite *.cpp,*.hpp :Autoformat
endif
