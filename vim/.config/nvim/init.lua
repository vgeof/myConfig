function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

	    nmap("<F6>",":NvimTreeToggle<CR>")
	    nmap("n","<F5>",":NvimTreeFindFile<CR>")

require('plugins')

vim.o.smartindent=true
vim.o.hidden=true
vim.o.tabstop=4        -- tab width is 4 spaces
-- configure tabwidth and insert spaces instead of tabs
vim.o.shiftwidth=4     -- indent also with 4 spaces
vim.o.expandtab=true        -- expand tabs to spaces
-- turn line numbers on
vim.o.number=true
vim.o.relativenumber=true
-- highlight matching braces
vim.o.showmatch=true
-- number of line to keep when scrolling
vim.o.so=15
vim.opt.whichwrap:append({"<",">","h","l"})
vim.o.ignorecase=true
vim.o.smartcase=true
--better tab completion in command mode
vim.o.wildmode="longest:full,full"
vim.o.wildignorecase=true
--vim.o.diffopt:append("vertical")
-- highlight current line
vim.o.cul=true
vim.o.ttimeoutlen=10
vim.o.updatetime=300
--mouse support
vim.o.mouse="a"
vim.o.conceallevel=2
--specific nvim--
vim.o.termguicolors=true
-- to avoid ESC delay with lightline
vim.o.ttimeoutlen=0
-- sign column always visible
vim.o.scl="yes"

require('lualine').setup()

vim.o.termguicolors=true
vim.o.background = "dark"
-- vim.o.gruvbox_italic=true
vim.g.gruvbox_contrast_dark='medium'
vim.g.gruvbox_vert_split="bg2"
vim.cmd([[colorscheme gruvbox]])
vim.cmd([[autocmd ColorScheme * highlight Normal guibg=None ctermbg=None]])


require('nvim-autopairs').setup{} 
 require'nvim-tree'.setup {}
 require('gitsigns').setup{}
nmap("<C-p>","<cmd>lua require('telescope.builtin').find_files()<cr>")
nmap("<F3>","<cmd>lua require('telescope.builtin').live_grep()<cr>")
nmap("<leader>b","<cmd>lua require('telescope.builtin').buffers()<cr>")
nmap("<F2>","<cmd>lua require('telescope.builtin').grep_string()<cr>")


require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
   rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
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
        ["ic"] = "@class.inner",

        -- Or you can define your own textobjects like this
        ["iF"] = {
          python = "(function_definition) @function",
          cpp = "(function_definition) @function",
          c = "(function_definition) @function",
          java = "(method_declaration) @function",
        },
      },
    },
  },
}
