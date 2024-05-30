return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"
    local job = require "plenary.job"
    local get_hl = require("astroui").get_hlgroup

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
      status.component.builder {
        provider = function() return gstatus.ahead .. "↑ " .. gstatus.behind .. "↓ " end,
        surround = { condition = status.condition.is_git_repo, separator = "None" },
        hl = function()
          if tonumber(gstatus.ahead) > 0 or tonumber(gstatus.behind) > 0 then return get_hl "StatusGitRemoteUnsync" end

          return get_hl "StatusGitRemoteSync"
        end,
      },
      status.component.file_info {
        filetype = false,
        filename = {},
        file_modified = { padding = { left = 1 } },
      },
      status.component.git_diff(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      status.component.diagnostics(),
      -- status.component.builder {
      --   provider = function()
      --     local codeium_status = vim.api.nvim_call_function("codeium#GetStatusString", {})
      --     return "  :" .. codeium_status .. " "
      --   end,
      --   hl = { fg = p.blue },
      -- },
      -- status.component.treesitter(),
      -- status.component.lsp {
      --   -- lsp_progress = true,
      --   padding = { left = 1, right = 1 },
      -- },
      status.component.builder {
        {
          provider = function()
            local indent_type = vim.bo.expandtab and "Space" or "Tab"
            local indent_size = vim.bo.shiftwidth
            return indent_type .. ": " .. indent_size .. " "
          end,
        },
        padding = { left = 1 },
        hl = get_hl "StatusTabSize",
        -- surround = { separator = "right" },
      },
      status.component.nav { scrollbar = false, percentage = false },
      status.component.mode { surround = { separator = "right" } },
    }
  end,
}
