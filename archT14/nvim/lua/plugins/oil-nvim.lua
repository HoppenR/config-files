-- Bookmarks
---@type table<string, string>
local oil_bookmarks = {
    ['/'] = '/',
    ['D'] = '~/Documents',
    ['P'] = '~/projects/personal',
    ['b'] = '~/.local/bin',
    ['c'] = '~/.config',
    ['h'] = '~',
    ['l'] = '~/Documents/LiU',
    ['n'] = '~/.config/nvim',
    ['p'] = '~/.config/nvim/lua/plugins',
    ['t'] = '~/Documents/LiU/TDDI16',
}

-- Ranger-like 'g' keybind for selecting a bookmarked location via a single key
local function bookmark_prompt()
    local oil = require("oil")
    local fns = require('functions')
    ---@type string[]
    local prompt_lines = { 'key' .. '\t\t' .. 'location' }
    for key, path in pairs(oil_bookmarks) do
        table.insert(prompt_lines, key .. '\t\t' .. path)
    end
    ---@type string
    local selected_key = fns.ranger_prompt(prompt_lines)
    ---@type string
    local target_path = oil_bookmarks[selected_key]
    if target_path then
        oil.open(target_path)
    end
end

-- Local keybinds
---@return table<string, function|string>
local function default_oil_binds()
    return {
        ['<C-b>'] = bookmark_prompt,
        -- ['cd'] = 'cd',
    }
end


-- Return Lazy config
return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        local oil = require("oil")
        oil.setup({
            default_file_explorer = true,
            columns = {
                "icon",
                -- "permissions",
                -- "size",
                -- "mtime",
            },
            keymaps = default_oil_binds(),
        })
        -- Global keybinds
        vim.keymap.set('n', '<M-e>', oil.open)
    end,
}
