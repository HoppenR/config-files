-- ~/.config/nvim/colors/wal.lua

vim.cmd.highlight('clear')
vim.o.background = 'dark'
if vim.fn.exists('syntax_on') then
    vim.cmd.syntax('reset')
end

-- Set colorscheme name
vim.g.colors_name = 'wal'

local fns = require('functions')
local wal_file = vim.fn.expand('~/.cache/wal/colors-wal.vim')

if vim.fn.filereadable(wal_file) == 1 then
    vim.cmd.source(wal_file)
else
    vim.notify(
        'No wal file found, using fallback colors',
        vim.log.levels.INFO,
        { title = 'wal.lua' }
    )
    vim.g.background = 'Black'
    vim.g.cursor = 'White'
    vim.g.foreground = 'White'
    vim.g.color0 = 'Black'
    vim.g.color1 = 'Red'
    vim.g.color2 = 'Green'
    vim.g.color3 = 'Yellow'
    vim.g.color4 = 'Blue'
    vim.g.color5 = 'Magenta'
    vim.g.color6 = 'Cyan'
    vim.g.color7 = 'White'
    vim.g.color8 = 'DarkGray'
    vim.g.color9 = 'LightRed'
    vim.g.color10 = 'LightGreen'
    vim.g.color11 = 'LightYellow'
    vim.g.color12 = 'LightBlue'
    vim.g.color13 = 'LightMagenta'
    vim.g.color14 = 'LightCyan'
    vim.g.color15 = 'White'
end

local StandoutBackground = fns.brighten_color(vim.g.color0, 20)

-- Set terminal_color for embedded nvim terminals
for i = 0, 15 do
    vim.g['terminal_color_' .. i] = vim.g['color' .. i]
end

-- Title should not be linked to 'Special'? (MarkdownH3 same style as markdownCode)
local highlights = {
    ['@constructor']                         = { link = 'Constructor' },
    ['@error']                               = { link = 'Error' },
    ['@lsp.type.namespace']                  = { link = 'Special' },
    ['@lsp.type.unresolvedReference']        = { link = 'DiagnosticUnderlineError' },
    ['@lsp.typemod.variable.defaultLibrary'] = { link = 'Special' },
    ['@lsp.typemod.variable.global']         = { link = 'Structure' },
    ['@namespace']                           = { link = 'Special' },
    ['@neorg.anchors.declaration']           = { fg = vim.g.color1 },
    ['@neorg.links.file']                    = { fg = vim.g.color6 },
    ['@neorg.markup.inline_math']            = { italic = true },
    ['@neorg.markup.italic.norg']            = { italic = true },
    -- ['@neorg.tags.ranged_verbatim.code_block'] = { bg = vim.g.color0 },
    ['@text.literal.block']                  = { bg = vim.g.color0 },
    ['@text.reference']                      = { link = '@text.uri' },
    ['@text.strong']                         = { bold = true },
    ['@text.uri']                            = { fg = vim.g.color1, underline = true },
    ['@variable.builtin']                    = { link = 'Special' },
    ['Boolean']                              = { fg = vim.g.color5 },
    ['Character']                            = { fg = vim.g.color1 },
    ['CmpItemAbbr']                          = { fg = vim.g.color7 },
    ['CmpItemAbbrMatch']                     = { fg = vim.g.color6 },
    ['CmpItemAbbrMatchFuzzy']                = { fg = vim.g.color6 },
    ['CmpItemKind']                          = { fg = vim.g.color4 },
    ['CmpItemKindFile']                      = { fg = vim.g.color4 },
    ['CmpItemMenu']                          = { fg = vim.g.color8 },
    ['ColorColumn']                          = { bg = StandoutBackground },
    ['Comment']                              = { fg = vim.g.color8, italic = true },
    ['Conceal']                              = { fg = 'Gray' },
    ['Conditional']                          = { fg = vim.g.color4, italic = true },
    ['Constant']                             = { link = 'Identifier' },
    ['Constructor']                          = { link = 'Structure' },
    ['CurSearch']                            = { link = 'IncSearch' },
    ['Cursor']                               = { fg = vim.g.color1 },
    ['CursorColumn']                         = { bg = vim.g.color8, fg = vim.g.color7 },
    ['CursorLine']                           = { bg = StandoutBackground },
    ['CursorLineNr']                         = { fg = vim.g.color6, reverse = true },
    ['Define']                               = { fg = vim.g.color5 },
    ['Delimiter']                            = { fg = vim.g.color5 },
    ['DiagnosticUnderlineError']             = { undercurl = true, special = 'Red' },
    ['DiagnosticUnderlineWarn']              = { undercurl = true, special = 'Orange' },
    ['DiffAdd']                              = { fg = vim.g.color2, reverse = true },
    ['DiffChange']                           = { fg = vim.g.color8, reverse = true },
    ['DiffDelete']                           = { fg = vim.g.color1 },
    ['DiffText']                             = { fg = vim.g.color6, reverse = true },
    ['Directory']                            = { fg = vim.g.color4 },
    ['EmptyHighlightGroup']                  = {},
    ['Error']                                = { bg = vim.g.color1, fg = vim.g.color7 },
    ['ErrorMsg']                             = { fg = vim.g.color8 },
    ['Float']                                = { fg = vim.g.color3 },
    ['FloatBorder']                          = { fg = vim.g.color7 },
    ['FoldColumn']                           = { fg = vim.g.color7 },
    ['Folded']                               = { fg = vim.g.color8 },
    ['Function']                             = { fg = vim.g.color2 },
    ['Identifier']                           = { fg = vim.g.color7 },
    ['Ignore']                               = { bg = vim.g.color8, fg = vim.g.color0 },
    ['IncSearch']                            = { bg = vim.g.color5, fg = vim.g.color0, underline = true , special = 'Black'},
    ['Include']                              = { fg = vim.g.color4 },
    ['Keyword']                              = { fg = vim.g.color5, italic = true },
    ['Label']                                = { fg = vim.g.color4 },
    ['LineNr']                               = { fg = vim.g.color6 },
    ['LspInfoBorder']                        = { fg = vim.g.color7 },
    ['MatchParen']                           = { bg = vim.g.color1, fg = vim.g.color0 },
    ['ModeMsg']                              = { fg = vim.g.color7 },
    ['MoreMsg']                              = { fg = vim.g.color2 },
    ['NonText']                              = { fg = 'Gray' },
    ['Normal']                               = { bg = vim.g.background, fg = vim.g.foreground },
    ['NormalFloat']                          = { fg = vim.g.color7 },
    ['NotifyERRORBody']                      = { link = 'Normal' },
    ['NotifyERRORBorder']                    = { fg = 'DarkRed' },
    ['NotifyERRORIcon']                      = { fg = 'Red' },
    ['NotifyERRORTitle']                     = { fg = 'Red' },
    ['NotifyINFOBody']                       = { link = 'Normal' },
    ['NotifyINFOBorder']                     = { fg = vim.g.color7 },
    ['NotifyINFOIcon']                       = { fg = vim.g.color8 },
    ['NotifyINFOTitle']                      = { fg = vim.g.color8 },
    ['NotifyWARNBody']                       = { link = 'Normal' },
    ['NotifyWARNBorder']                     = { fg = vim.g.color1 },
    ['NotifyWARNIcon']                       = { fg = vim.g.color2 },
    ['NotifyWARNTitle']                      = { fg = vim.g.color2 },
    ['Number']                               = { fg = vim.g.color3 },
    ['Operator']                             = { fg = vim.g.color7 },
    ['Pmenu']                                = { bg = StandoutBackground, fg = vim.g.color7 },
    ['PmenuSbar']                            = { fg = vim.g.color6, bg = vim.g.color7 },
    ['PmenuSel']                             = { bg = vim.g.color5, fg = vim.g.color0 },
    ['PmenuThumb']                           = { bg = vim.g.color8, fg = vim.g.color8 },
    ['PreProc']                              = { fg = vim.g.color3 },
    ['Question']                             = { fg = vim.g.color4 },
    ['Repeat']                               = { fg = vim.g.color4, italic = true },
    ['Search']                               = { bg = vim.g.color6, fg = vim.g.color0 },
    ['SignifySignAdd']                       = { fg = vim.g.color2 },
    ['SignifySignChange']                    = { fg = vim.g.color4 },
    ['SignifySignDelete']                    = { fg = vim.g.color1 },
    ['Special']                              = { fg = vim.g.color6, bold = true },
    ['SpecialChar']                          = { fg = vim.g.color5 },
    ['SpecialKey']                           = { fg = vim.g.color8 },
    ['SpellBad']                             = { undercurl = true, special = 'Green' },
    ['SpellCap']                             = { undercurl = true, special = 'Green' },
    ['SpellLocal']                           = { undercurl = true, special = 'Green' },
    ['SpellRare']                            = { undercurl = true, special = 'Green' },
    ['Statement']                            = { fg = vim.g.color1 },
    ['StatusLine']                           = { bg = vim.g.color2, fg = vim.g.color0 },
    ['String']                               = { fg = vim.g.color2 },
    ['Structure']                            = { fg = vim.g.color1, bold = true },
    ['TSError']                              = { underline = true },
    ['TabLine']                              = { fg = vim.g.color8 },
    ['TabLineFill']                          = { fg = vim.g.color8 },
    ['TabLineSel']                           = { bg = vim.g.color4, fg = vim.g.color0 },
    ['Tag']                                  = { fg = vim.g.color3 },
    ['TelescopeMatching']                    = { fg = 'NONE' },
    ['TermCursorNC']                         = { bg = vim.g.color3, fg = vim.g.color0 },
    ['Title']                                = { link = 'Special' },
    ['Todo']                                 = { bg = vim.g.color2, fg = vim.g.color0 },
    ['Type']                                 = { fg = vim.g.color3 },
    ['Underlined']                           = { fg = vim.g.color7, underline = true },
    ['VertSplit']                            = { fg = vim.g.color2 },
    ['Visual']                               = { bg = vim.g.color5, fg = vim.g.color0 },
    ['VisualNOS']                            = { fg = vim.g.color1 },
    ['WarningMsg']                           = { bg = vim.g.color1, fg = vim.g.color0 },
    ['WildMenu']                             = { bg = vim.g.color2, fg = vim.g.color0 },
    ['Winbar']                               = { fg = vim.g.color7, bold = true },
    ['WinbarNC']                             = { fg = vim.g.color8 },
    ['i3ConfigBindKeyword']                  = { link = 'Keyword' },
    ['signColumn']                           = { fg = vim.g.color4 },
    ['vimAutoCmd']                           = { link = 'vimUserCommand' },
    ['vimCommand']                           = { link = 'vimUserCommand' },
    ['vimFTCmd']                             = { link = 'vimUserCommand' },
    ['vimLet']                               = { link = 'vimUserCommand' },
    ['vimMap']                               = { link = 'vimUserCommand' },
    ['vimNotFunc']                           = { link = 'vimUserCommand' },
    ['vimUserCommand']                       = { fg = vim.g.color1 },
    ['xdefaultsValue']                       = { fg = vim.g.color7 },
}

for group, opts in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, opts)
end
