--
-- ~/.config/nvim/lua/functions.lua
--

---@alias fail table<nil, string, string>

local M = {}

function M.set_insert_brace_bindings()
    ---@type table<string, string>
    local braces = {
        ['('] = ')',
        ['['] = ']',
        ['{'] = '}',
    }
    ---@type table<string, string>
    local closings = {
        ',',
        ';',
        '',
    }
    for open, close in pairs(braces) do
        for _, post in ipairs(closings) do
            vim.keymap.set(
                'i',
                open .. post .. '<CR>',
                open .. '<CR>' .. close .. post .. '<Esc>O'
            )
        end
    end
end

---@param file string The filename or path
---@return boolean success Whether the file exists and is readable
function M.file_exist_and_readable(file)
    ---@type boolean|fail
    local readable = vim.loop.fs_access(file, 'r')
    if readable == nil then return false end

    ---@type table|fail
    local stat = vim.loop.fs_stat(file)
    if stat == nil then return false end

    return readable and stat.type == 'file'
end

-- function M.highlight_cursor_word()
--     local cword = vim.fn.expand('<cword>')
--     -- Escape the word if it is an identifier
--     if vim.fn.match(cword, [[\w]]) >= 0 then
--         cword = [[\<]] .. cword .. [[\>]]
--     end
--     vim.opt.hlsearch = true
--     vim.fn.setreg('/', cword)
--     vim.api.nvim_echo({ { cword, 'None' } }, false, {})
-- end

function M.make_if_makefile_exist()
    if M.file_exist_and_readable('./makefile') then
        vim.cmd.make({ bang = true })
        vim.cmd.cwindow()
    end
end

function M.set_lead_indent_chars()
    vim.opt_local.listchars:append({
        leadmultispace = '│' .. string.rep(' ', vim.fn.shiftwidth() - 1)
    })
end

function M.set_golang_settings()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 8
end

function M.set_ocaml_settings()
    vim.opt_local.shiftwidth = 2
end

function M.set_terminal_settings()
    vim.cmd.startinsert()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
end

---Display lines of text in a floating window at the bottom of the screen
---indented to show keybind:command lines like in ranger
---@param lines_to_display string[] The lines to draw
---@return string key The pressed key
function M.ranger_prompt(lines_to_display)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines_to_display)
    local gheight = vim.api.nvim_list_uis()[1].height
    local gwidth = vim.api.nvim_list_uis()[1].width
    local opts = {
        style = 'minimal',
        relative = 'win',
        width = gwidth - 2,
        height = #lines_to_display,
        row = (gheight - #lines_to_display - 5),
        col = 0,
        focusable = false,
        border = 'rounded',
        zindex = 100,
    }
    local win = vim.api.nvim_open_win(buf, false, opts)
    vim.cmd.redraw()
    local key = vim.fn.nr2char(vim.fn.getchar())
    vim.api.nvim_win_close(win, { force = true })
    return key
end

---Adjust R, G, and B values in a hex string by a number amount
---@param hexcolor string The input hexcolor
---@param amt number The change amount
---@return string brightened
function M.brighten_color(hexcolor, amt)
    local r = tonumber(hexcolor:sub(2, 3), 16) or 0
    local g = tonumber(hexcolor:sub(4, 5), 16) or 0
    local b = tonumber(hexcolor:sub(6, 7), 16) or 0
    return string.format("#%02X%02X%02X", r + amt, g + amt, b + amt)
end

-- function M.multiline_next_char_occurrence()
--     local ch_code = vim.fn.getchar()
--     local ch = vim.fn.nr2char(ch_code)
--     vim.fn.search('\\V' .. ch)
-- end

---Construct a partial function
---@param f function
---@param arg1 any argument for f
---@return function
function M.partial(f, arg1)
    return function(...)
        return f(arg1, ...)
    end
end

-- function M.safecall(f, ...)
--     local success, result = pcall(f, ...)
--     if not success then
--         vim.print(result)
--     end
-- end

---@param direction string
function M.term_split(direction)
    if direction == 'v' then
        vim.cmd.vnew()
    elseif direction == 'h' then
        vim.cmd.new()
    end
    vim.cmd.terminal()
end

return M
