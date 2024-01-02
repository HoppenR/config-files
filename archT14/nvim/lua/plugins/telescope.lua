-- Global keybinds
local function default_telescope_binds()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader><leader>', builtin.builtin)
    vim.keymap.set('n', '<leader>b', builtin.buffers)
    vim.keymap.set('n', '<leader>f', builtin.find_files)
    vim.keymap.set('n', '<leader>g', builtin.live_grep)
    vim.keymap.set('n', '<leader>i', builtin.lsp_implementations)
    vim.keymap.set('n', '<leader>l', builtin.diagnostics)
    vim.keymap.set('n', '<leader>r', builtin.lsp_references)
    vim.keymap.set('n', '<leader>s', builtin.lsp_document_symbols)
    vim.keymap.set('n', '<leader>t', builtin.current_buffer_fuzzy_find)
end

-- Return Lazy config
return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local actions = require('telescope.actions')
        require('telescope').setup({
            defaults = {
                winblend = vim.o.winblend,
                scroll_strategy = 'limit',
                mappings = {
                    n = {
                        ['<C-b>'] = actions.preview_scrolling_up,
                        ['<C-d>'] = actions.results_scrolling_down,
                        ['<C-f>'] = actions.preview_scrolling_down,
                        ['<C-u>'] = actions.results_scrolling_up,
                        ['<Esc>'] = false,
                        ['q'] = actions.close,
                    },
                    i = {
                        ['<C-d>'] = actions.close,
                        ['<C-u>'] = false,
                    },
                },
            },
            pickers = {
                buffers = {
                    mappings = {
                        n = {
                            ['dd'] = actions.delete_buffer,
                        },
                    },
                },
            },
        })
        default_telescope_binds()
    end,
}
