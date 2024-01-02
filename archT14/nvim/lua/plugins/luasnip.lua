return {
    'L3MON4D3/LuaSnip',
    config = function()
        local ls = require('luasnip')
        local ls_ext = require('luasnip.extras')
        local ins_n = ls.insert_node
        local rep_n = ls_ext.rep
        local txt_n = ls.text_node
        ls.config.set_config({
            history = false,
            updateevents = "TextChanged,TextChangedI",
        })
        ls.add_snippets('go', {
            ls.snippet('errnil', {
                txt_n({ 'if err != nil {', '\treturn ' }),
                ins_n(1, 'err'),
                txt_n({ '', '}' }),
            }),
            ls.snippet('printdebug', {
                txt_n({ 'fmt.Printf("DEBUG (' }),
                rep_n(1),
                txt_n({ '): %s", ' }),
                ins_n(1),
                txt_n({ ')' }),
            }),
        })
        -- Global keybinds
        vim.keymap.set({ 'i', 's' }, '<C-l>', function() ls.jump(1) end)
        vim.keymap.set({ 'i', 's' }, '<C-h>', function() ls.jump(-1) end)
    end
}
