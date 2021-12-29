if &shell =~# 'fish$'
	    set shell=sh
endif

call plug#begin()
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'scrooloose/nerdtree'
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
"Plug 'mhinz/vim-signify'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'w0rp/ale'
Plug 'jpalardy/vim-slime'
""Plug 'Maximbaz/lightline-ale'
Plug 'tomasiser/vim-code-dark'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
" NOTE : les 2 plugins suivants vont ensemble
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'dag/vim-fish'
"Plug 'romgrk/nvim-treesitter-context'
Plug 'kassio/neoterm'
Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'
Plug 'liuchengxu/vista.vim'
Plug 'hrsh7th/nvim-compe'
Plug 'glepnir/lspsaga.nvim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
"Plug 'nvim-telescope/telescope.nvim'
Plug 'windwp/nvim-spectre'
Plug 'puremourning/vimspector'
"Plug 'steelsojka/completion-buffers'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
call plug#end()


" """""""""""""""" nvim default"
" set UTF-8 encoding
"let g:gutentags_ctags_extra_args=["--c++-kinds=+p --fields=+iaS --extra=+q"]
set enc=utf-8
set fenc=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smarttab
set wrap
" turn syntax highlighting on
set t_Co=256
syntax on
" colorscheme wombat256
set autoread
set backspace=eol,start,indent
set hlsearch
set incsearch
set showcmd
set background=dark
set foldmethod=syntax
set foldnestmax=10
set nofoldenable
set foldlevel=2
set cmdheight=1


""""""" non nvim default"
set smartindent
set hidden
set tabstop=4        " tab width is 4 spaces
" configure tabwidth and insert spaces instead of tabs
set shiftwidth=4     " indent also with 4 spaces
set expandtab        " expand tabs to spaces
" turn line numbers on
set number
set relativenumber
" highlight matching braces
set showmatch
" number of line to keep when scrolling
set so=15
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
"better tab completion in command mode
set wildmode=longest:full,full
set wildignorecase
set diffopt+=vertical
" highlight current line
set cul
set ttimeoutlen=10
set updatetime=300
"mouse support
set mouse=a
set conceallevel=2
"specific nvim"
set termguicolors
" to avoid ESC delay with lightline
set ttimeoutlen=0
" sign column always visible
set scl=yes

" left and right do not select match in command mode
cnoremap <Left> <Space><BS><Left>
cnoremap <Right> <Space><BS><Right>

" open quickfix windo below vertical split
au FileType qf wincmd J

""Airline"
"let g:airline#extensions#disable_rtp_load = 1
"let g:airline_extensions = []
"let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

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
nnoremap <C-p> <cmd>Files<cr>
nnoremap <F2> <cmd>Occ<cr>
nnoremap <F3> <cmd>RG<cr>



" key mappings
"inoremap kj <esc>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> <c-p> :Files<CR>
nmap <F1> :BLines<CR>
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
            \'rust': ['rustfmt'],
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
let g:UltiSnipsExpandTrigger = "<A-Enter>"
let g:UltiSnipsJumpForwardTrigger = "<A-Enter>"
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
  py3f /usr/share/clang/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp,*.hpp,*.c,*.cxx,*.hxx call Formatonsave()

"vim ccls
"let g:ccls_size = 20
"let g:ccls_position = 'botright'
"let g:ccls_orientation = 'horizontal'

" vimtex
 let g:tex_flavor = 'latex'


lua <<EOF
require('gitsigns').setup{
signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  }}

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
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<F10>', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<F4>', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
  buf_set_keymap('n', '<F7>', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)



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



local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

require'lspconfig'.clangd.setup{on_attach=on_attach ;cmd = { "clangd","--clang-tidy" ,"--background-index", "--suggest-missing-includes",  "--completion-style=detailed" }, capabilities = capabilities}

require'lspconfig'.pylsp.setup{on_attach=on_attach}
require'lspconfig'.bashls.setup{on_attach=on_attach}
require'lspconfig'.tsserver.setup{on_attach=on_attach}
require'lspconfig'.rust_analyzer.setup{
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
}

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    path = true;
    nvim_lsp = true;
  };
}
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("UltiSnips#CanExpandSnippet",{}) == 1 then
    return vim.fn['UltiSnips#ExpandSnippet']()
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})




--local actions = require('telescope.actions')
---- Global remapping
--------------------------------
--require('telescope').setup{
--  defaults = {
--    scroll_strategy = nil,
--    mappings = {
--      i = {
--        -- Otherwise, just set the mapping to the function that you want it to be.
--        ["<C-j>"] = actions.move_selection_next,
--        ["<C-k>"] = actions.move_selection_previous,
--
--      },
--      n = {
--        ["<C-j>"] = actions.move_selection_next,
--        ["<C-k>"] = actions.move_selection_previous,
--      },
--    },
--  }
--}

EOF

"nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>
"nnoremap <F3> <cmd>lua require('telescope.builtin').live_grep()<cr>
"nnoremap <F2> <cmd>lua require('telescope.builtin').grep_string()<cr>
"nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>


local saga = require 'lspsaga'
saga.init_lsp_saga()
nnoremap <silent> <M-CR> <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent> <M-CR> :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <silent><space>rn <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
nnoremap <silent><leader>cc <cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>
nnoremap <silent> [d <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>
nnoremap <silent> ]d <cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>
nnoremap <silent> gr <cmd>lua require'lspsaga.provider'.lsp_finder()<CR>



inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')

" Set completeopt to have a better completion experience
set completeopt=menuone,noselect

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.vsnips = v:false
"inoremap <silent><expr> <CR>      compe#confirm('<CR>')
"inoremap <silent><expr> <C-e>     compe#close('<C-e>')
set shortmess+=c

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
"autocmd BufWinEnter,WinEnter term://* startinsert
"startinsert

"Neoterm
let g:neoterm_autoinsert = 1
let g:neoterm_default_mod='rightbelow vert'
let g:neoterm_size = 95
let g:neoterm_fixedsize = 1
let g:neoterm_auto_repl_cmd=0
let g:neoterm_autoscroll=1
let g:neoterm_shell="fish"
let g:neoterm_repl_enable_ipython_paste_magic=1



"theme settings
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark = 'medium'
"let g:solarized_termcolors=256
let g:gruvbox_vert_split="bg2"
colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

"easymotion
let g:EasyMotion_smartcase = 1
"nvim signs
highlight link GitSignsAdd GruvboxGreen
highlight link GitSignsChange GruvboxOrange
highlight link GitSignsDelete GruvboxRed

nnoremap <leader>h :ClangdSwitchSourceHeader<CR>


" spectre
nnoremap <leader>S :lua require('spectre').open()<CR>

"vimtext config
let g:vimtex_text_obj_linewise_operators=0
