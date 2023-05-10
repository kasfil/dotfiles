return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local p = require("catppuccin.palettes").get_palette "macchiato"
    local status = require "astronvim.utils.status"
    local job = require "plenary.job"

    -- [[
    -- this code stolen from https://www.reddit.com/r/neovim/comments/t48x5i/comment/hyx6fkl/?utm_source=share&utm_medium=web2x&context=3
    local gstatus = { ahead = 0, behind = 0 }
    local function update_gstatus()
      job
        :new({
          command = "git",
          args = { "rev-list", "--left-right", "--count", "HEAD...@{upstream}" },
          on_exit = function(fetch, _)
            local res = fetch:result()[1]
            if type(res) ~= "string" then
              gstatus = { ahead = 0, behind = 0 }
              return
            end
            local ok, ahead, behind = pcall(string.match, res, "(%d+)%s*(%d+)")
            if not ok then
              ahead, behind = 0, 0
            end
            gstatus = { ahead = ahead, behind = behind }
          end,
        })
        :start()
    end

    if _G.Gstatus_timer == nil then
      _G.Gstatus_timer = vim.loop.new_timer()
    else
      _G.Gstatus_timer:stop()
    end

    _G.Gstatus_timer:start(0, 2000, vim.schedule_wrap(update_gstatus))
    -- ]]

    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.git_branch(),
      {
        provider = function() return gstatus.ahead .. "↑ " .. gstatus.behind .. "↓ " end,
        condition = status.condition.is_git_repo,
        surround = status.utils.surround { " ", " " },
      },
      status.component.file_info { filetype = {}, filename = false, file_modified = false },
      status.component.git_diff(),
      status.component.diagnostics(),
      {
        provider = function()
          local codeium_status = vim.api.nvim_call_function("codeium#GetStatusString", {})
          return " Codeium: " .. codeium_status .. " "
        end,
        hl = { fg = p.blue },
        surround = status.utils.surround { " ", " " },
      },
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.lsp(),
      status.component.treesitter(),
      status.component.builder {
        {
          provider = function()
            local indent_type = vim.bo.expandtab and "Space" or "Tab"
            local indent_size = vim.bo.shiftwidth
            return " " .. indent_type .. ": " .. indent_size .. " "
          end,
        },
        padding = { left = 1 },
        hl = { fg = p.yellow },
        surround = { separator = "right" },
      },
      status.component.nav {
        percentage = { padding = { right = 0 } },
        ruler = { padding = { left = 0 } },
        scrollbar = false,
        surround = { separator = "none" },
      },
      status.component.mode { surround = { separator = "right" } },
    }
  end,
}
