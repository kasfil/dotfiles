--[[
    This config takes inspiration from:
        - github.com/voitd/dotfiles
]]

local cmd, api = vim.cmd, vim.api

local M = {}

function M.apply_options(opts)
    for key, value in pairs(opts) do
        if value == true then
            cmd("set " .. key)
        elseif value == false then
            cmd(string.format("set no%s", key))
        else
            cmd(string.format("set %s=%s", key, value))
        end
    end
end

function M.map(mode, key, result, opts)
    opts = vim.tbl_extend(
        "keep",
        opts or {},
        {
            noremap = true,
            silent = true,
            expr = false
        }
    )
    -- set keymap
    api.nvim_set_keymap(mode, key, result, opts)
end

function M.highlink(group, linked)
    cmd(string.format("hi! link " .. group .. " " .. linked))
end


function M.highlight(group, styles)
  local gui = styles.gui and 'gui='..styles.gui or 'gui=NONE'
  local sp = styles.sp and 'guisp='..styles.sp or 'guisp=NONE'
  local fg = styles.fg and 'guifg='..styles.fg or 'guifg=NONE'
  local bg = styles.bg and 'guibg='..styles.bg or 'guibg=NONE'
  vim.api.nvim_command('highlight! '..group..' '..gui..' '..sp..' '..fg..' '..bg)
end

return M
