--
-- ~/.config/nvim/init.lua
--

vim.cmd.filetype({ args = { 'plugin', 'indent', 'on' } })
vim.cmd.syntax('on')

--- VARIABLES
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = ' '
vim.g.neorg_leader = 'm'
-- vim.g.xdg_data_home = os.getenv('XDG_DATA_HOME') or os.getenv('HOME') .. '/.local/share'

if vim.fn.has('gui_running') == 1 then
    vim.opt.guifont = { 'monospace', ':h15' }
else
    vim.o.termguicolors = true
end

--- PLUGINS
if not vim.g.lazy_did_setup then
    vim.opt.runtimepath:prepend(vim.fn.stdpath('data') .. '/lazy/lazy.nvim')
    require('lazy').setup('plugins', { ui = { border = 'rounded' } })
end

--- COLORSCHEME
vim.cmd.colorscheme('wal')

--- FUNCTIONS
local fns = require('functions')

--- BOOLEAN OPTIONS
vim.o.autochdir = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.fileignorecase = true
vim.o.ignorecase = true
vim.o.list = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.ruler = false
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.title = true
vim.o.undofile = true
vim.o.wrap = false

--- STRING / NUMBER OPTIONS
vim.o.clipboard = 'unnamed'
vim.o.colorcolumn = '80'
vim.o.conceallevel = 2
vim.o.foldmethod = 'marker'
vim.o.laststatus = 3
vim.o.pumblend = 30
vim.o.shiftwidth = 0
vim.o.shortmess = 'AFOTWiost'
vim.o.statusline = table.concat({
    -- Left
    ' ',
    '%F', -- Long filename
    '%=', -- Separate sections
    -- Right
    ' 󱑜 %{&fileencoding} ',
    '  %{&filetype} ',
    '  %{&fileformat} ',
    ' %l %v ',
    ' %p%% ',
})
vim.o.tabstop = 4
vim.o.textwidth = 80
vim.o.timeoutlen = 500
vim.o.titlestring = '%F — NVIM'
vim.o.ttimeoutlen = 50
vim.o.winbar = '%=%f %r%m%='
vim.o.winblend = 30

--- LIST OPTIONS
vim.opt.cinoptions = { ':0', 'g0', '(0', 'W4', 'l1' }
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.foldmarker = { '{{{', '}}}' }
-- NOTE: vim.opt_local.listchars['leadmultispace'] is set in AutoSetIndentChars
vim.opt.listchars = { extends = '▸', nbsp = '◇', tab = '│ ', trail = '∘' }
vim.opt.matchpairs = { '(:)', '{:}', '[:]', '<:>' }

--- MAPPINGS
vim.keymap.set('n', '<C-S-j>', '<cmd>move+1<CR>')
vim.keymap.set('n', '<C-S-k>', '<cmd>move-2<CR>')
vim.keymap.set('n', '<C-w>N', '<cmd>vnew<CR>')
vim.keymap.set('n', '<C-w>T', '<cmd>vsplit +terminal<CR>')
vim.keymap.set('n', '<C-w>t', '<cmd>split +terminal<CR>')
vim.keymap.set('n', '<F1>', '<cmd>setlocal spell!<CR>')
vim.keymap.set('n', '<M-S-a>', vim.treesitter.inspect_tree, { desc = 'Show language tree' })
vim.keymap.set('n', '<M-S-n>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<M-S-p>', '<cmd>cprevious<CR>')
vim.keymap.set('n', '<M-a>', vim.show_pos, { desc = 'Show language items' })
vim.keymap.set('n', '_', ':lua ')
vim.keymap.set('n', 'ä', '<cmd>LspInfo<CR>')
vim.keymap.set('n', 'ö', '<cmd>Lazy<CR>')
vim.keymap.set('v', '¤', 'c<C-r>=<C-r>"<CR><Esc>', { desc = 'Evaluate highlighted expr' })

-- Viewport
vim.keymap.set('n', '<Down>', '<C-e>')
vim.keymap.set('n', '<Left>', 'zh')
vim.keymap.set('n', '<Right>', 'zl')
vim.keymap.set('n', '<Up>', '<C-y>')

-- Resize
vim.keymap.set('n', '<S-Down>', '<C-w>-')
vim.keymap.set('n', '<S-Left>', '<C-w><')
vim.keymap.set('n', '<S-Right>', '<C-w>>')
vim.keymap.set('n', '<S-Up>', '<C-w>+')

-- Braces
fns.set_insert_brace_bindings()

-- Graphical menu deletions
if not vim.g.removed_menu_options then
    vim.cmd.aunmenu('PopUp.-1-')
    vim.cmd.aunmenu('PopUp.How-to\\ disable\\ mouse')
    vim.g.removed_menu_options = true
end

--- AUTOCOMMANDS
-- Run makeprg if a makefile is in the same directory on buffer write
---@type number
local AutoMake = vim.api.nvim_create_augroup(
    'AutoMake',
    { clear = true }
)
vim.api.nvim_create_autocmd(
    'BufWritePost',
    {
        pattern = { '*.c', '*.cc', '*.cpp', '*.go', '*.rs' },
        group = AutoMake,
        callback = fns.make_if_makefile_exist,
    }
)

-- Set settings for built-in neovim terminals
---@type number
local TerminalSettings = vim.api.nvim_create_augroup(
    'TerminalSettings',
    { clear = true }
)
vim.api.nvim_create_autocmd(
    'TermOpen',
    {
        pattern = 'term://*',
        group = TerminalSettings,
        callback = fns.set_terminal_settings,
    }
)
vim.api.nvim_create_autocmd(
    'TermClose',
    {
        pattern = 'term://*',
        group = TerminalSettings,
        command = 'bdelete',
    }
)

-- Dynamically set the indent chars to the shiftwidth value
-- once on a new buffer and every time a relevant option is changed
---@type number
local AutoSetIndentChars = vim.api.nvim_create_augroup(
    'AutoSetIndentChars',
    { clear = true }
)
vim.api.nvim_create_autocmd(
    'OptionSet',
    {
        pattern = { 'shiftwidth', 'tabstop' },
        group = AutoSetIndentChars,
        callback = fns.set_lead_indent_chars,
    }
)
vim.api.nvim_create_autocmd(
    'BufWinEnter',
    {
        pattern = '*',
        group = AutoSetIndentChars,
        callback = fns.set_lead_indent_chars,
    }
)

-- Standard settings for Golang files
---@type number
local GolangSettings = vim.api.nvim_create_augroup(
    'GolangSettings',
    { clear = true }
)
vim.api.nvim_create_autocmd(
    'FileType',
    {
        pattern = 'go',
        group = GolangSettings,
        callback = fns.set_golang_settings,
    }
)

-- Standard settings for OCAML files
---@type number
local OCAMLSettings = vim.api.nvim_create_augroup(
    'OCAMLSettings',
    { clear = true }
)
vim.api.nvim_create_autocmd(
    'FileType',
    {
        pattern = 'ocaml',
        group = OCAMLSettings,
        callback = fns.set_ocaml_settings,
    }
)
