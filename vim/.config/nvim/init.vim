if &shell =~# 'fish$'
	    set shell=sh
endif

call plug#begin('~/.vim/plugged')
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'scrooloose/nerdtree'
"Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'ap/vim-buftabline'
Plug 'editorconfig/editorconfig-vim'
"Plug 'leafgarland/typescript-vim'
"Plug 'quramy/tsuquyomi'
Plug 'HerringtonDarkholme/yats.vim'
"Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
"Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
" For async completion
Plug 'Quramy/vim-js-pretty-template'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'altercation/vim-colors-solarized'
""Plug 'prettier/vim-prettier', { 'do': 'npm install' }
"Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'w0rp/ale'
Plug 'jpalardy/vim-slime'
""Plug 'Maximbaz/lightline-ale'
""Plug 'kien/ctrlp.vim'
Plug 'tomasiser/vim-code-dark'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
"Plug 'kien/rainbow_parentheses.vim'
"Plug 'junegunn/rainbow_parentheses.vim'
Plug 'luochen1990/rainbow'
Plug 'vim-scripts/a.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
"Plug 'Chiel92/vim-autoformat'
Plug 'majutsushi/tagbar'
Plug 'embear/vim-localvimrc'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'm-pilia/vim-ccls'
Plug 'AndrewRadev/linediff.vim'
Plug 'ap/vim-css-color'
Plug 'lervag/vimtex'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'dag/vim-fish'
"Plug 'steelsojka/completion-buffers'
call plug#end()


" set UTF-8 encoding
"let g:gutentags_ctags_extra_args=["--c++-kinds=+p --fields=+iaS --extra=+q"]
set enc=utf-8
set fenc=utf-8
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
set autoread
set so=15
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
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
set ttimeoutlen=10
set updatetime=300
set cmdheight=1


let g:airline#extensions#disable_rtp_load = 1
let g:airline_extensions = []

let isremote = system("df -P -T $PWD | grep fuse ")
if !empty(isremote)
    let g:airline#extensions#disable_rtp_load = 1
    let g:airline_extensions = []
endif
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

command! Send :execute "!" '~/Code/BE/updateServer.sh'
let g:fzf_layout = { 'window': { 'width': 0.99, 'height': 0.7 } }

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
autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
let g:NERDTreeWinSize=50
let g:plug_window = 'noautocmd vertical topleft new'


au BufRead,BufNewFile *.ts   setfiletype typescript
au BufRead,BufNewFile *.amalog   setfiletype amalog
au BufRead,BufNewFile *.amalog   :RainbowToggleOff
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
au BufRead,BufNewFile *.web,*.web.log,*.play,*.play.log,*.edi,*.edi.log set filetype=play


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
let g:ale_linters = {'python':['pylint'],'typescript':['tslint'] ,'cpp':[]}
"", 'cpp':['cppcheck']
let g:ale_fixers = {
            \'html':['tslint'],
            \'scss': ['tslint'] , 
            \'typescript': ['tslint'],
            \'json': ['prettier'],
            \'sh': ['shfmt'],
            \'javascript': ['tslint'],
            \'xml': ['xmllint'],
            \'python':['autopep8']}
"let g:ale_fix_on_save = 1
highlight link ALEErrorSign ALEWarningSign
nmap FF <Plug>(ale_fix)



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
"let g:cpp_class_scope_highlight = 1
"let g:cpp_member_variable_highlight = 1
"let g:cpp_class_decl_highlight = 1

" Settings for indentguides"
hi IndentGuidesOdd  ctermbg=black
hi IndentGuidesEven ctermbg=darkgrey
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup = 1


" Settings for airline"
let g:airline_powerline_fonts = 1
let g:airline_highlighting_cache = 1


"settings for ycm
"let g:ycm_auto_trigger = 1
"let g:ycm_use_clangd = 1
"let g:ycm_clangd_uses_ycmd_caching = 0
"let g:ycm_disable_signature_help = 0
""let g:ycm_collect_identifiers_from_tags_files = 1
""let g:ycm_add_preview_to_completeopt = 0
"let g:ycm_autoclose_preview_window_after_completion = 1
""let g:ycm_max_diagnostics_to_display = 0
"let g:ycm_clangd_binary_path = exepath("clangd")
""let g:ycm_server_log_level = 'debug'
"let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'
"let g:ycm_enable_diagnostic_signs = 1
""set completeopt-=preview 
"let g:ycm_max_num_candidates = 20
"let g:ycm_max_num_identifier_candidates = 10
"let g:ycm_min_num_of_chars_for_completion = 2
"let g:ycm_clangd_args = ['--limit-results=30','--header-insertion=never']
"if has("autocmd")
"    autocmd FileType typescript,cpp,hpp nnoremap <C-]> :YcmCompleter GoTo<CR>
"endif

"settings for ultisnips
let g:UltiSnipsExpandTrigger = "<Enter>"
let g:UltiSnipsJumpForwardTrigger = "<Enter>"
let g:UltiSnipsJumpBackwardTrigger = "<s-Enter>"



"settings for gitgutter"
"let g:gitgutter_terminal_reports_focus=0


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

"function! LoadCscope()
"    let db = findfile("cscope.out", ".;")
"    if (!empty(db))
"        let path = strpart(db, 0, match(db, "/cscope.out$"))
"        set nocscopeverbose " suppress 'duplicate connection' error
"        exe "cs add " . db . " " . path
"        set cscopeverbose
"        " else add the database pointed to by environment variable
"    elseif $CSCOPE_DB != ""
"        cs add $CSCOPE_DB
"    endif
"endfunction
"au BufEnter /* call LoadCscope()

" autoformat settings
"let g:formatdef_amadeus_format =  '"astyle -A10 --indent=spaces=4 --indent-classes --indent-cases --indent-switches --convert-tabs --indent-col1-comments --add-brackets --max-instatement-indent=120 --min-conditional-indent=0 --pad-oper --pad-comma --pad-header --unpad-paren --align-pointer=type --align-reference=type --preserve-date -n  --lineend=linux --formatted"'
"    let g:formatters_cpp = ['amadeus_format']
"    au BufWrite *.cpp,*.hpp :Autoformat
"

"tagbar 
nmap <F8> :TagbarToggle<CR>


"coc 
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"nnoremap <silent> K :call <SID>show_documentation()<CR>

"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  else
"    call CocAction('doHover')
"  endif
"endfunction
"
"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)



" float-preview
"let g:float_preview#docked = 1

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

" vimtex
 let g:tex_flavor = 'latex'


lua <<EOF
require'lspconfig'.ccls.setup{
root_dir = require'lspconfig'.util.root_pattern("compile_commands.json", ".ccls");
  init_options = {
            cache = {
                directory = "/home/vgeoffroy/.ccls-cache";
            };
    };
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = false
        }
      }
    }
  },
}
require'lspconfig'.tsserver.setup{}
require'lspconfig'.pyls.setup{}
require'lspconfig'.bashls.setup{}
require "nvim-treesitter.parsers".get_parser_configs().markdown = nil
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",    
  highlight = {
    enable = true
    },
    incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
      },
    },
    textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  }  
 }
EOF


nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>


let g:completion_trigger_keyword_length = 1
let g:completion_matching_ignore_case = 1
let g:completion_matching_strategy_list = ['exact', 'substring',]
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'snippet']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]

let g:completion_auto_change_source = 1



" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect
"
"" Avoid showing message extra message when using completion
let g:completion_enable_snippet = 'UltiSnips'
set shortmess+=c
autocmd BufEnter * lua require'completion'.on_attach()
