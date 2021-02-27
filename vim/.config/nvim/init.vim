if &shell =~# 'fish$'
	    set shell=sh
endif

call plug#begin()
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'scrooloose/nerdtree'
"Plug 'ervandew/supertab'
Plug 'vim-airline/vim-airline'
Plug 'editorconfig/editorconfig-vim'
"Plug 'leafgarland/typescript-vim'
"Plug 'quramy/tsuquyomi'
Plug 'HerringtonDarkholme/yats.vim'
"Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'Quramy/vim-js-pretty-template'
Plug 'junegunn/vim-peekaboo'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'gruvbox-community/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'altercation/vim-colors-solarized'
""Plug 'prettier/vim-prettier', { 'do': 'npm install' }
Plug 'mhinz/vim-signify'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'w0rp/ale'
Plug 'jpalardy/vim-slime'
""Plug 'Maximbaz/lightline-ale'
Plug 'tomasiser/vim-code-dark'
Plug 'lukas-reineke/indent-blankline.nvim' ,{ 'branch': 'lua' }
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
"Plug 'kien/rainbow_parentheses.vim'
"Plug 'junegunn/rainbow_parentheses.vim'
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
Plug 'lervag/vimtex'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'dag/vim-fish'
Plug 'romgrk/nvim-treesitter-context'
Plug 'kassio/neoterm'
Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'
Plug 'liuchengxu/vista.vim'
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
"mouse support
set mouse=a
set conceallevel=2
"specific nvim"
set termguicolors
" to avoid ESC delay with lightline
set ttimeoutlen=0


""Airline"
"let g:airline#extensions#disable_rtp_load = 1
"let g:airline_extensions = []
"let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

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

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec,'up:30%'), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

let g:fzf_layout = { 'window': { 'width': 0.99, 'height': 0.7 } }



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
nmap <leader>b :Buffers<CR>



"restoring last cursor position
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

" typescript-vim config

" js-pretty-template settings
autocmd FileType typescript JsPreTmpl
"autocmd FileType typescript syn clear foldBraces " For leafgarland/typescript-vim users only. Please see #1 for details.
au BufRead,BufNewFile *.web,*.web.log,*.play,*.play.log,*.edi,*.edi.log,*.gsv,*.gsv.log set filetype=play


" tsuquyomi settings
" let g:tsuquyomi_use_vimproc = 1
"
" nvim-typescript
let g:nvim_typescript#default_mappings = 1
let g:nvim_typescript#diagnostics_enable = 0 " I use YCM to show diagnostics

" lightline settings
""set laststatus=2
set noshowmode


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
            \'python':['autopep8'],
            \'*':['trim_whitespace']}
"let g:ale_fix_on_save = 1
highlight link ALEErrorSign ALEWarningSign
nmap FF <Plug>(ale_fix)



" Settings for indentblankline"
let g:indent_blankline_char_list = ['|', '¦', '┆', '┊']
let g:indent_blankline_char_highlight = 'NonText'
let g:indent_blankline_buftype_exclude = ['terminal']
"let g:indent_blankline_show_first_indent_level = v:false


" Settings for airline"
let g:airline_powerline_fonts = 1
"let g:airline_highlighting_cache = 1



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




"tagbar
nmap <F8> :Vista!!<CR>
nmap <F9> :lua vim.lsp.stop_client(vim.lsp.get_active_clients())<CR>:e<CR>


"vista options
"let g:vista#renderer#enable_icon = 1
let g:vista_sidebar_position="rightbelow vert"

" clang format options

function! Formatonsave()
  let l:lines="all"
  pyf ~/.vim/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp,*.hpp,*.c,*.cxx,*.hxx call Formatonsave()

"vim ccls
"let g:ccls_size = 20
"let g:ccls_position = 'botright'
"let g:ccls_orientation = 'horizontal'

" vimtex
 let g:tex_flavor = 'latex'


lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
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

 local nvim_lsp = require('lspconfig')
 local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  local opts = { noremap=true, silent=true }
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<F10>', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<F4>', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
  buf_set_keymap('n', '<F7>', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)


  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      hi LspReferenceRead cterm=bold ctermbg=black
      hi LspReferenceText  cterm=bold ctermbg=black
      hi LspReferenceWrite cterm=bold ctermbg=black
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end
end

--require'lspconfig'.ccls.setup{
--on_attach=on_attach;
--root_dir = require'lspconfig'.util.root_pattern("compile_commands.json", ".ccls");
--  init_options = {
--            cache = {
--                directory = "/home/vgeoffroy/.ccls-cache";
--            };
--    };
--  capabilities = {
--    textDocument = {
--      completion = {
--        completionItem = {
--          snippetSupport = false
--        }
--      }
--    }
--  },
--}
require'lspconfig'.clangd.setup{on_attach=on_attach;
 cmd = { "/home/vgeoffroy/Code/clangd_snapshot_20210124/bin/clangd", "--background-index" ,"--clang-tidy"};
  init_options = {
            cache = {
                directory = "/home/vgeoffroy/.clangd-cache";
            };
    };
 }
require'lspconfig'.tsserver.setup{on_attach=on_attach}
require'lspconfig'.pyls.setup{on_attach=on_attach}
require'lspconfig'.bashls.setup{on_attach=on_attach}
EOF


let g:completion_trigger_keyword_length = 1
let g:completion_matching_smart_case = 1
let g:completion_matching_strategy_list = ['exact', 'substring',]
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp', 'snippet']},
    \{'complete_items': ['path']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]
let g:completion_sorting = "none"

let g:completion_trigger_on_delete = 1
let g:completion_auto_change_source = 1



" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noselect,noinsert
"
"" Avoid showing message extra message when using completion
let g:completion_enable_snippet = 'UltiSnips'
set shortmess+=c
autocmd BufEnter * lua require'completion'.on_attach()


" fix to Alt+Enter
nnoremap <silent> <M-CR> <cmd>lua vim.lsp.buf.code_action()<CR>

"peekabo
let g:peekaboo_window='rightbelow vert 35new'


"terminal options
"tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
"inoremap <A-h> <C-\><C-N><C-w>hi
"inoremap <A-j> <C-\><C-N><C-w>ji
"inoremap <A-k> <C-\><C-N><C-w>ki
"inoremap <A-l> <C-\><C-N><C-w>li
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
autocmd TermOpen * setlocal nonumber norelativenumber
nnoremap <A-\|> :Tnew<CR>
nnoremap <A--> :belowright Tnew<CR><C-\><C-N>:resize 20<CR>i
tnoremap <A--> <C-\><C-N>:belowright Tnew<CR><C-\><C-N>:resize 20<CR>i
autocmd BufWinEnter,WinEnter term://* startinsert
"startinsert

"Neoterm
let g:neoterm_autoinsert = 1
let g:neoterm_default_mod='rightbelow vert'
let g:neoterm_size = 95
let g:neoterm_fixedsize = 1
let g:neoterm_auto_repl_cmd=0
let g:neoterm_autoscroll=1
let g:neoterm_shell="fish"



"theme settings
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark = 'medium'
"let g:solarized_termcolors=256
let g:gruvbox_vert_split="bg2"
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE
