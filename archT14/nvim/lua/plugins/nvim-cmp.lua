-- Scroll to next entry, inserting it, or fall back to opening completion
local function insert_next_or_complete(cmp)
    return function()
        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
        else
            cmp.complete()
        end
    end
end

-- Scroll to prev entry, inserting it, or fall back to opening completion
local function insert_prev_or_complete(cmp)
    return function()
        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
        else
            cmp.complete()
        end
    end
end

-- Scroll to next entry, only selecting it, or use sensible fallback
local function select_next_or_fallback(cmp)
    return function(fallback)
        if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
            fallback()
        end
    end
end

-- Scroll to prev entry, only selecting it, or use sensible fallback
local function select_prev_or_fallback(cmp)
    return function(fallback)
        if cmp.visible() then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
        else
            fallback()
        end
    end
end

-- Local keybinds
local function default_cmp_keybinds(cmp)
    return {
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'c', 'i' }),
        ['<C-e>'] = cmp.mapping(cmp.mapping.abort(), { 'c', 'i' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'c', 'i' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'c', 'i' }),
        ['<C-n>'] = cmp.mapping(insert_next_or_complete(cmp), { 'c', 'i' }),
        ['<C-p>'] = cmp.mapping(insert_prev_or_complete(cmp), { 'c', 'i' }),
        ['<C-y>'] = cmp.mapping(cmp.mapping.confirm(), { 'c', 'i' }),
        ['<Tab>'] = {
            c = insert_next_or_complete(cmp),
        },
        ['<S-Tab>'] = {
            c = insert_prev_or_complete(cmp),
        },
    }
end

-- Return Lazy config
return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'L3MON4D3/LuaSnip', -- for snippet support in config
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
        'saadparwaiz1/cmp_luasnip', -- for snippet source in config
    },
    config = function()
        local cmp = require('cmp')
        local cmp_shared_mappings = default_cmp_keybinds(cmp)
        cmp.setup({
            completion = {
                keyword_length = 3,
            },
            mapping = cmp_shared_mappings,
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end,
            },
            sources = cmp.config.sources(
                {
                    { name = 'neorg' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'path' },
                }, {
                    -- Fallback sources
                    { name = 'buffer', option = { keyword_pattern = [[\k\+]] } },
                }
            ),
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        })
        -- ':' -> Normal commands
        -- '@' -> User defined commands, like vim.ui.input()
        cmp.setup.cmdline({ ':', '@' }, {
            mapping = cmp_shared_mappings,
            sources = cmp.config.sources(
                {
                    { name = 'cmdline' },
                    { name = 'path' },
                }
            )
        })
        -- '/' | '?' -> Searching
        cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp_shared_mappings,
            completion = {
                -- Auto suggestions prevents scrolling up in search history
                -- with the <Up> and <Down> arrow keys
                autocomplete = false,
            },
            sources = {
                { name = 'buffer' }
            }
        })
    end,
}
