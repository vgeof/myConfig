" VIM Configuration File
" Description: Optimized for C/C++ development, but useful also for other things.
" Author: Gerhard Gappmeier
"

call plug#begin('~/.vim/plugged')
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'scrooloose/nerdtree'
Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'ap/vim-buftabline'
Plug 'editorconfig/editorconfig-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'Quramy/vim-js-pretty-template'
Plug 'honza/vim-snippets'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'altercation/vim-colors-solarized'
Plug 'mhinz/vim-signify'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'f4t-t0ny/nerdtree-hg-plugin'
Plug 'w0rp/ale'
Plug 'jpalardy/vim-slime'
Plug 'tomasiser/vim-code-dark'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'luochen1990/rainbow'
Plug 'vim-scripts/a.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'majutsushi/tagbar'
Plug 'embear/vim-localvimrc'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'm-pilia/vim-ccls'
Plug 'AndrewRadev/linediff.vim'
Plug 'ap/vim-css-color'
call plug#end()

set hidden
" configure tabwidth and insert spaces instead of tabs
set tabstop=4        " tab width is 4 spaces
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" wrap lines at 300 chars. 80 is somewaht antiquated with nowadays displays.
set textwidth=300
" turn syntax highlighting on
set t_Co=256
syntax on
" colorscheme wombat256
" turn line numbers on
set number
set relativenumber
" highlight matching braces
set showmatch
set so=15
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase

set wildignorecase
set diffopt+=vertical
set cul
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=2
set ttimeoutlen=10
set updatetime=1000
set shortmess+=c
" fzf options  
let g:fzf_preview_window = 'right:40%'
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --glob "!.clangd/*" --glob "!.hg/* " --glob "!.tags "--no-messages --color "always" '.shellescape(<q-args>), 1, <bang>0)

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

command Occ :execute 'Find ' .expand('<cword>')
"set cscopetag

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec,'up:30%'), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

let g:fzf_layout = { 'window': { 'width': 0.99, 'height': 0.7 } }

"specific nvim"
if has('nvim')
    set termguicolors
    let g:gruvbox_italic=1
endif


" to avoid ESC delay with lightline
set ttimeoutlen=0


" key mappings
"inoremap kj <esc>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> <c-p> :Files<CR>
nmap <F1> :BLines<CR>
nmap <F2> :Occ<CR>
nmap <F3> :RG<CR>
nmap <F5> :NERDTreeFind<CR>
nmap <F6> :NERDTreeToggle<CR>
nmap <F10> :CocList diagnostics<CR>
nmap <F12> :w<CR>:Send<CR>
nmap <leader>b :Buffers<CR>



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
au BufRead,BufNewFile *.amalog   setfiletype amalog
au BufRead,BufNewFile *.amalog   :RainbowToggleOff


" js-pretty-template settings
autocmd FileType typescript JsPreTmpl
au BufRead,BufNewFile *.play,*.play.log,*.edi,*.edi.log set filetype=play




"theme settings
let g:gruvbox_contrast_dark = 'medium'
"let g:solarized_termcolors=256
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE







"Settings for ALE
let g:ale_linters = {'python':['pylint'],'typescript':['tslint'] ,'cpp':[]}
"", 'cpp':['cppcheck']
let g:ale_fixers = {
            \'html':['prettier'],
            \'scss': ['prettier'] , 
            \'typescript': ['prettier'],
            \'json': ['prettier'],
            \'sh': ['shfmt'],
            \'javascript': ['prettier']}
            "\'xml': ['xmllint'],
let g:ale_fix_on_save = 1
            "\'python':['autopep8'],
highlight link ALEErrorSign ALEWarningSign







" Settings for indentguides"
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1


" Settings for airline"
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1



"settings for ultisnips
let g:UltiSnipsExpandTrigger = "<TAB>"
let g:UltiSnipsJumpForwardTrigger = "<TAB>"
let g:UltiSnipsJumpBackwardTrigger = "<s-TAB>"


"settings for vim slime
let g:slime_target = "tmux"
let g:slime_python_ipython = 1


"settings for rainbow
"au VimEnter * RainbowParentheses
"let g:rainbow#pairs = [['(', ')'], ['[', ']'],['{','}']]
let g:rainbow_active =1

"settings for signify
let g:signify_vcs_list = [ 'git', 'hg' ]


"settings for ctrlp
"set wildignore+=*node_modules/*,*.so,*.swp,*.zip





"tagbar 
nmap <F8> :TagbarToggle<CR>


"coc 
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" clang format options

function! Formatonsave()
  let l:lines="all"
  pyf ~/.vim/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp,*.hpp,*.c,*.cxx,*.hxx call Formatonsave()

"vim ccls
let g:ccls_size = 20
let g:ccls_position = 'botright'
let g:ccls_orientation = 'horizontal'


