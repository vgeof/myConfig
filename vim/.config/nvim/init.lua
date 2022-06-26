function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command,
                            {noremap = true, silent = true})
end

function nmap(shortcut, command) map('n', shortcut, command) end

function imap(shortcut, command) map('i', shortcut, command) end
function tmap(shortcut, command) map('t', shortcut, command) end
function vmap(shortcut, command) map('v', shortcut, command) end

nmap("<F6>", ":NvimTreeToggle<CR>")
nmap("<F5>", ":NvimTreeFindFile<CR>")

require('plugins')

vim.o.smartindent = true
vim.o.hidden = true
vim.o.tabstop = 4 -- tab width is 4 spaces
-- configure tabwidth and insert spaces instead of tabs
vim.o.shiftwidth = 4 -- indent also with 4 spaces
vim.o.expandtab = true -- expand tabs to spaces
-- turn line numbers on
vim.o.number = true
vim.o.relativenumber = true
-- highlight matching braces
vim.o.showmatch = true
-- number of line to keep when scrolling
vim.o.so = 15
-- vim.opt.whichwrap:append({"<",">","h","l"})
vim.o.ignorecase = true
vim.o.smartcase = true
-- better tab completion in command mode
vim.o.wildmode = "longest:full,full"
vim.o.wildignorecase = true
----vim.o.diffopt:append("vertical")
vim.cmd([[set diffopt+=vertical]])
vim.cmd([[set whichwrap+=<,>,h,l]])
-- highlight current line
vim.o.cul = true
vim.o.ttimeoutlen = 10
vim.o.updatetime = 300
-- mouse support
vim.o.mouse = "a"
vim.o.conceallevel = 2
-- specific nvim--
vim.o.termguicolors = true
-- to avoid ESC delay with lightline
vim.o.ttimeoutlen = 0
-- sign column always visible
vim.o.scl = "yes"
vim.o.showmode = false

require('lualine').setup({
    options = {globalstatus = false},
    sections = {
        lualine_c = {
            {
                'filename',
                file_status = true, -- displays file status (readonly status, modified status)
                path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
                shorting_target = 40 -- Shortens path to leave 40 space in the window
                -- for other components. Terrible name any suggestions?
            }
        }
    },
    inactive_sections = {
        lualine_c = {
            {
                'filename',
                file_status = true, -- displays file status (readonly status, modified status)
                path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
                shorting_target = 40 -- Shortens path to leave 40 space in the window
                -- for other components. Terrible name any suggestions?
            }
        }
    }
})

vim.o.termguicolors = true
vim.o.background = "dark"
-- vim.o.gruvbox_italic=true
vim.g.gruvbox_contrast_dark = 'medium'
vim.g.gruvbox_vert_split = "bg2"
vim.cmd([[autocmd ColorScheme * highlight Normal guibg=None ctermbg=None]])
vim.cmd([[colorscheme gruvbox]])

require('nvim-autopairs').setup {}
require('gitsigns').setup {}
nmap("<C-p>", "<cmd>lua require('telescope.builtin').find_files()<cr>")
nmap("<F3>", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
nmap("<leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>")
nmap("<F2>", "<cmd>lua require('telescope.builtin').grep_string()<cr>")
nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")

require'nvim-treesitter.configs'.setup {
    ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false
    },
    rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner"
            }
        }
    }
}

require("indent_blankline").setup {

    char_list = {'|', '¦', '┆', '┊'},
    char_highlight_list = {'NonText'},
    buftype_exclude = {'terminal'}

}

-- require'compe'.setup {
--    enabled = true,
--    autocomplete = true,
--    debug = false,
--    min_length = 1,
--    preselect = 'enable',
--    throttle_time = 80,
--    source_timeout = 200,
--    incomplete_delay = 400,
--    max_abbr_width = 100,
--    max_kind_width = 100,
--    max_menu_width = 100,
--    documentation = true,
--
--    source = {path = true, nvim_lsp = true}
-- }
-- local t = function(str)
--    return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
--
-- local check_back_space = function()
--    local col = vim.fn.col('.') - 1
--    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
--        return true
--    else
--        return false
--    end
-- end
--
---- Use (s-)tab to:
----- move to prev/next item in completion menuone
-- _G.tab_complete = function()
--    if vim.fn.pumvisible() == 1 then
--        return t "<C-n>"
--        -- elseif vim.fn.call("UltiSnips#CanExpandSnippet",{}) == 1 then
--        -- return vim.fn['UltiSnips#ExpandSnippet']()
--    elseif check_back_space() then
--        return t "<Tab>"
--    else
--        return vim.fn['compe#complete']()
--    end
-- end
-- _G.s_tab_complete = function()
--    if vim.fn.pumvisible() == 1 then
--        return t "<C-p>"
--    else
--        return t "<S-Tab>"
--    end
-- end
--
-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

-- restore cursor position
vim.cmd(
    [[autocmd BufReadPost * if @% !~# '\.git[\/\\]COMMIT_EDITMSG$' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]])

nmap("<leader>S", ":lua require('spectre').open()<CR>")

tmap("<A-h>", "<C-\\><C-N><C-w>h")
tmap("<A-j>", "<C-\\><C-N><C-w>j")
tmap("<A-k>", "<C-\\><C-N><C-w>k")
tmap("<A-l>", "<C-\\><C-N><C-w>l")
nmap("<A-h>", "<C-w>h")
nmap("<A-j>", "<C-w>j")
nmap("<A-k>", "<C-w>k")
nmap("<A-l>", "<C-w>l")
nmap("<A-|>", ":Tnew<CR>")
nmap("<A-->", ":belowright Tnew<CR><C-\\><C-N>:resize 20<CR>i")
tmap("<A-->", "<C-\\><C-N>:belowright Tnew<CR><C-\\><C-N>:resize 20<CR>i")

vim.cmd([[autocmd TermOpen * setlocal nonumber norelativenumber]])
vim.g.neoterm_autoinsert = true
vim.g.neoterm_default_mod = 'rightbelow vert'
vim.g.neoterm_size = 95
vim.g.neoterm_fixedsize = true
vim.g.neoterm_auto_repl_cmd = false
vim.g.neoterm_autoscroll = true
vim.g.neoterm_shell = "fish"
vim.g.neoterm_repl_enable_ipython_paste_magic = true

local nvim_lsp = require('lspconfig')
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    local opts = {noremap = true, silent = true}
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<space>D',
                   '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<F10>', '<cmd>TroubleToggle document_diagnostics<cr>',
                   opts)
    buf_set_keymap('n', '<F4>', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>',
                   opts)
    buf_set_keymap('n', '<F7>', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>',
                   opts)
    buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>',
                   opts)

    --  if client.resolved_capabilities.document_highlight then
    --    vim.api.nvim_exec([[
    --      hi LspReferenceRead cterm=bold ctermbg=black
    --      hi LspReferenceText  cterm=bold ctermbg=black
    --      hi LspReferenceWrite cterm=bold ctermbg=black
    --      augroup lsp_document_highlight
    --        autocmd! * <buffer>
    --        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    --        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    --      augroup END
    --    ]], false)
    --  end
end

local saga = require 'lspsaga'
saga.init_lsp_saga()
nmap("<M-CR>", "<cmd>lua require('lspsaga.codeaction').code_action()<CR>")
vmap("<M-CR>", ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>")
nmap("K", "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>")
-- nmap("gs", "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>")
nmap("<space>rn", "<cmd>lua require('lspsaga.rename').rename()<CR>")
nmap("<leader>cd",
     "<cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>")
nmap("<leader>cc",
     "<cmd>lua require'lspsaga.diagnostic'.show_cursor_diagnostics()<CR>")
nmap("[d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>")
nmap("]d", "<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>")
nmap("gr", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>")
nmap("gR", "<cmd>Trouble lsp_references<cr>")

nmap("<leader>h", ":ClangdSwitchSourceHeader<CR>")
nmap("<leader>S", ":lua require('spectre').open()<CR>")

-- \ "cmake"      : "cmake-format --command-case lower -",
-- \ "css"        : "css-beautify -s 2 --space-around-combinator",
-- \ "go"         : "gofmt",
-- \ "html"       : "tidy -q -w -i --show-warnings 0 --show-errors 0 --tidy-mark no",
-- \ "java"       : "uncrustify --l JAVA base kr mb java",
-- \ "javascript" : "js-beautify -s 2",
-- \ "json"       : "js-beautify -s 2",
-- \ "python"     : "autopep8 -",
-- \ "sql"        : "sqlformat -k upper -r -",
-- \ "xhtml"      : "tidy -asxhtml -q -m -w -i --show-warnings 0 --show-errors 0 --tidy-mark no --doctype loose",
-- \ "xml"        : "tidy -xml -q -m -w -i --show-warnings 0 --show-errors 0 --tidy-mark no",
-- vim.cmd([[let s:formatprg_for_filetype = {
--      \ "c"          : "clang-format",
--      \ "cpp"        : "clang-format",
--      \}
-- for [ft, fp] in items(s:formatprg_for_filetype)
--  execute "autocmd FileType ".ft." let &l:formatprg=\"".fp."\" | setlocal formatexpr="
-- endfor
-- autocmd BufWritePre *.cpp,*.hpp,*.h :normal gggqG
-- ]])

nmap("FF", ":Format<CR>")
require('formatter').setup({
    filetype = {
        cpp = {
            -- clang-format
            function()
                return {
                    exe = "clang-format-11",
                    args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
                    stdin = true,
                    cwd = vim.fn.expand('%:p:h') -- Run clang-format in cwd of the file.
                }
            end
        },
        -- luaformat
        lua = {function() return {exe = "lua-format ", stdin = true} end},
        rust = {function() return {exe = "rustfmt", stdin = true} end}
    }
})
vim.cmd [[augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.cpp,*.hpp,*.h FormatWrite
augroup END]]

-- luaeval()
vim.cmd([[
command BCommits :lua require'telescope.builtin'.git_bcommits{} 
]])

local telescope = require("telescope")
telescope.setup {
    defaults = {
        mappings = {
            i = {
                ["<C-j>"] = "move_selection_next",
                ["<C-k>"] = "move_selection_previous"
                -- ["<C-t>"] = "trouble.open_with_trouble"
            }

            -- n = {["<c-t>"] = trouble.open_with_trouble}
        }
    },
    pickers = {
        buffers = {
            ignore_current_buffer = true,
            sort_mru = true,
            sort_lastused = true
        }
    },
    extensions = {
        fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case" -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    }
}
require('telescope').load_extension('fzf')
require('nvim-autopairs').setup({fast_wrap = {}})

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and
               vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col,
                                                                          col)
                   :match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true),
                          mode, true)
end

vim.cmd([[set completeopt=menu,menuone,noselect]])
local cmp = require 'cmp'

local ELLIPSIS_CHAR = '…'
local MAX_LABEL_WIDTH = 80
local MIN_LABEL_WIDTH = 3

cmp.setup({
    -- view = {
    --    entries = "native" -- can be "custom", "wildmenu" or "native"
    -- },
    completion = {keywork_length = 1},
    sorting = {
        comparators = {
            function(entry1, entry2)
                local score1 = entry1.completion_item.score
                local score2 = entry2.completion_item.score
                if score1 and score2 then
                    local diff = score1 - score2
                    if diff < 0 then
                        return false
                    elseif diff > 0 then
                        return true
                    end
                end
            end, -- The built-in comparators:
            cmp.config.compare.offset, cmp.config.compare.exact,
            cmp.config.compare.score, cmp.config.compare.kind,
            cmp.config.compare.sort_text, cmp.config.compare.length,
            cmp.config.compare.order
        }
    },
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end
    },
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                print("1")
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
                print("2")
            elseif has_words_before() then
                cmp.complete()
                print("3")
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, {"i", "s"}),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, {"i", "s"}),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {'i', 'c'}),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {'i', 'c'}),
        ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close()
        })
        -- ['<CR>'] = cmp.mapping.confirm({select = true})
    },
    sources = cmp.config.sources({
        {name = 'nvim_lsp'}, {name = 'vsnip'},
        {name = 'nvim_lsp_signature_help'}, {name = 'buffer'}, {name = 'path'}
    }),
    formatting = {
        format = function(entry, vim_item)
            local label = vim_item.abbr
            local truncated_label = vim.fn
                                        .strcharpart(label, 0, MAX_LABEL_WIDTH)
            if truncated_label ~= label then
                vim_item.abbr = truncated_label .. ELLIPSIS_CHAR
            elseif string.len(label) < MIN_LABEL_WIDTH then
                local padding = string.rep(' ',
                                           MIN_LABEL_WIDTH - string.len(label))
                vim_item.abbr = label .. padding
            end
            return vim_item
        end
    }
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {sources = {{name = 'buffer'}}})
--
---- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--    sources = cmp.config.sources({{name = 'path', keyword_length = 1}},
--                                 {{name = 'cmdline', keyword_length = 2}})
-- })
--
-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp
                                                                     .protocol
                                                                     .make_client_capabilities())
require'lspconfig'.clangd.setup {
    on_attach = on_attach,
    cmd = {
        "clangd", "--clang-tidy", "--background-index",
        "--completion-style=bundled"
    },
    capabilities = capabilities
}

require'lspconfig'.pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
require'lspconfig'.bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
require'lspconfig'.rust_analyzer.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- require"lsp_signature".setup()

require("trouble").setup {}

vim.diagnostic.config({severity_sort = true})
