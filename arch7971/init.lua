vim.cmd [[
    colorscheme personal
    filetype plugin indent on
    syntax on
]]

-- Load the packer-config lua file
require('plugins')

-- Set up LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

local default_lsp_binds = function()
    vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, {buffer=0})
    vim.keymap.set('n', '<F3>', vim.lsp.buf.format, {buffer=0})
    vim.keymap.set('n', '<Tab>', vim.lsp.buf.hover, {buffer=0})
    vim.keymap.set('n', '<leader>dl', '<cmd>Telescope diagnostics<CR>', {buffer=0})
    vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, {buffer=0})
    vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, {buffer=0})
    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {buffer=0})
    vim.keymap.set('n', '<leader>gf', vim.lsp.buf.code_action, {buffer=0})
    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, {buffer=0})
    vim.keymap.set('n', '<leader>gs', '<cmd>Telescope lsp_document_symbols<CR>', {buffer=0})
    vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition, {buffer=0})
end

lspconfig.gopls.setup{
    capabilities = capabilities,
    on_attach = default_lsp_binds,
}

lspconfig.clangd.setup{
    capabilities = capabilities,
    on_attach = default_lsp_binds,
}

-- Set up nvim-cmp.
local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

-- Boolean options
vim.o.autochdir = true
vim.o.autoindent = true
vim.o.cursorline = true
vim.o.expandtab = true
vim.o.fileignorecase = true
vim.o.foldenable = true
vim.o.hidden = false
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.list = true
vim.o.number = true
vim.o.ruler = false
vim.o.showcmd = true
vim.o.smartcase = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.timeout = true
vim.o.title = true
vim.o.undofile = true
vim.o.wildmenu = true
vim.o.wrap = false

-- String options
vim.o.clipboard = 'unnamed'
vim.o.colorcolumn = 80
vim.o.encoding = 'utf-8'
vim.o.foldmethod = 'marker'
vim.o.grepprg = 'grep -nH $*'
vim.o.laststatus = 2
vim.o.shiftwidth = 4
vim.o.signcolumn = 'yes'
vim.o.statusline = '%F %-7h%-4m%-5r%y%=%-21(L:%3l C:%3v pos:%p%%%)'
vim.o.tabstop = 4
vim.o.textwidth = 80
vim.o.timeoutlen = 500
vim.o.titleold = ''
vim.o.titlestring = '%f %-7h%-4m%-5r- VIM'
vim.o.ttimeoutlen = 50
vim.o.undodir = '/home/christoffer/.config/nvim/undo'
vim.o.undolevels = 1000
vim.o.undoreload = 10000
vim.o.wildcharm = '<C-Z>'

-- List options
vim.opt.cinoptions = {':0', 'g0', '(0', 'W4', 'l1'}
vim.opt.completeopt = {"menu", "menuone", "noselect"}
vim.opt.foldmarker = {'{{{', '}}}'}
vim.opt.listchars = {tab = '│ ', trail = '~', eol = '¬'}

-- Mappings
vim.keymap.set('i', '<C-j>', '<Plug>luasnip-expand-or-jump', {remap=false})
vim.keymap.set('i', '{<CR>', '{<CR>}<Esc>O', {remap = false})
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>', {remap=false})
vim.keymap.set('n', '<C-k>', '<cmd>cprevious<CR>', {remap=false})
vim.keymap.set('n', '<C-w>t', '<cmd>vsplit +terminal<CR>', {remap = false})
vim.keymap.set('n', '<F4>', ':emenu <C-Z>', {remap = false})
vim.keymap.set('n', '<leader>fd', '<cmd>Telescope find_files<CR>', {buffer=0})
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', {buffer=0})
vim.keymap.set('n', '½', '<cmd>nohlsearch<CR>', {remap = false})
vim.keymap.set('t', '<C-w>N', '<C-\\><C-N>', {remap = false})

-- Variables
vim.g.mapleader = ' '

-- Autocommands
local AutoMake = vim.api.nvim_create_augroup('AutoMake', {clear = true})
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*.{c,cpp,go}',
    group = AutoMake,
    callback = function()
        if file_exists('./makefile') then
            vim.cmd('make')
            vim.cmd('cwindow')
        end
    end
})

local AutoShellcheck = vim.api.nvim_create_augroup('AutoShellcheck', {clear = true})
vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    group = AutoShellcheck,
    callback = function()
        if vim.bo.filetype == 'sh' and not vim.wo.diff and vim.api.nvim_eval('match(expand("%:p"), "/tmp")') ~= 0 then
            vim.bo.makeprg = 'shellcheck -f gcc %'
        end
    end
})

vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = '*',
    group = AutoShellcheck,
    callback = function()
        if vim.bo.filetype == 'sh' and not vim.wo.diff and vim.api.nvim_eval('match(expand("%:p"), "/tmp")') ~= 0 then
            vim.cmd('make!')
            vim.cmd('cwindow')
        end
    end
})

-- Functions
function file_exists(file)
   local ok, err, code = os.rename(file, file)
   if not ok then
      if code == 13 then
         -- Permission denied, but it exists
         return true
      end
   end
   return ok, err
end
