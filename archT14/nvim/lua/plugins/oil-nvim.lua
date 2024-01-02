-- Bookmarks
---@type { key: string, path: string }[]
local oil_bookmarks = {
    { key = '/', path = '/' },
    { key = 'D', path = '~/Documents' },
    { key = 'P', path = '~/projects/personal' },
    { key = 'b', path = '~/.local/bin' },
    { key = 'c', path = '~/.config' },
    { key = 'h', path = '~' },
    { key = 'l', path = '~/Documents/LiU' },
    { key = 'n', path = '~/.config/nvim' },
    { key = 'p', path = '~/.config/nvim/lua/plugins' },
    { key = 't', path = '~/Documents/LiU/TDDI16' },
}

-- Ranger-like 'g' keybind that offers a selection of bookmarks and movement
local function bookmark_prompt()
    local oil = require("oil")
    local fns = require('functions')
    ---@type string[]
    local prompt_lines = { 'key' .. '\t\t' .. 'location' }
    for _, bookmark in ipairs(oil_bookmarks) do
        table.insert(
            prompt_lines,
            string.format('%2s\t\t%s', bookmark.key, bookmark.path)
        )
    end
    ---@type string
    local key = fns.ranger_prompt(prompt_lines)
    ---@type string
    local target_path
    for _, bookmark in ipairs(oil_bookmarks) do
        if key == bookmark.key then
            target_path = bookmark.path
            break
        end
    end
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
