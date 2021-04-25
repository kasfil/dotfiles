local highlight = require("configs.utils").highlight

vim.cmd("colorscheme blue-moon")

local _M = {}

-- Blue-moon preset
_M.colors = {
    bg_darker      = '#121622' ,
    bg_dark        = '#1b1e2b' ,
    bg             = '#292d3e' ,
    bg_light       = '#32374d' ,
    bg_lighter     = '#444267' ,
    grey           = '#8796b0' ,
    grey_dark      = '#353b52' ,
    red            = '#d06178' ,
    red_dimmed     = '#a05168' ,
    heavy_red      = '#e61f44' ,
    green          = '#b4c4b4' ,
    green_high     = '#bcd9c4' ,
    blue           = '#959dcb' ,
    blue_light     = '#b8bcf3' ,
    yellow         = '#cfcfbf' ,
    orange         = '#b4b4b4' ,
    purple         = '#b9a3eb' ,
    cyan_dark      = '#89bbdd' ,
    cyan           = '#89ddff' ,
    fg             = '#a6accd' ,
    fg_light       = '#fbfbfb' ,
    fg_dark        = '#676e96' ,
    hollow         = '#424760' ,
    hollow_lighter = '#30354e' ,
    white          = '#ffffff' ,
}

local colors = _M.colors
-- new Highlight
local new_highlight = {
    StatusLine = { bg = colors.bg_dark },
    StatuslineNc = { bg = colors.bg },
    ColorColumn = { bg = colors.bg },
    NonText = { fg = colors.bg },

    -- barbar.nvim
    BufferCurrent = { fg = "#b8bcf3" },
    BufferCurrentIndex = { fg = "#b8bcf3" },
    BufferCurrentMod = { fg = "#cfcfbf", gui = "bold"},
    BufferCurrentSign = { fg = "#a6accd" },
    BufferCurrentTarget = { fg = "#d06178" },
    BufferVisible = { fg = "#b8bcf3", bg = "#32374d" },
    BufferVisibleIndex = { fg = "#b8bcf3", bg = "#32374d" },
    BufferVisibleMod = { fg = "#cfcfbf", bg = "#32374d", gui = "bold" },
    BufferVisibleSign = { fg = "#a6accd", bg = "#32374d" },
    BufferVisibleTarget = { fg = "#d06178" },
    BufferInactive = { fg = "#676e96", bg = "#32374d" },
    BufferInactiveIndex = { fg = "#676e96", bg = "#32374d" },
    BufferInactiveMod = { fg = "#cfcfbf", bg = "#32374d", gui = "bold" },
    BufferInactiveSign = { fg = "#a6accd", bg = "#32374d" },
    BufferInactiveTarget = { fg = "#d06178" },
    BufferTabpageFill = { bg = "#32374d" },

    -- Indent Guides
    IndentGuidesOdd = { bg = "#292d3e" },
    IndentGuidesEven = { bg = "#1b1e2b" },
}

for group, styles in pairs(new_highlight) do
    highlight(group, styles)
end

return _M
