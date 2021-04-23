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

return M
