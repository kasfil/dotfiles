return {
  "rebelot/heirline.nvim",
  lazy = false,
  config = function()
    local heirline = require "heirline"
    local conditions = require "heirline.conditions"
    local utils = require "heirline.utils"
    local comp = require "user.utils.bar-components"

    heirline.setup {
      opts = {
        disable_winbar_cb = function(args)
          local bt = { "terminal", "prompt", "nofile", "help", "quickfix" }
          local ft = { "NvimTree", "neo%-tree", "dashboard", "Outline", "aerial" }

          return not (vim.api.nvim_buf_is_valid(args.buf) and vim.bo[args.buf].buflisted)
            or vim.tbl_contains(bt, vim.bo[args.buf].buftype)
            or vim.tbl_contains(ft, vim.bo[args.buf].filetype)
        end,
      },
      winbar = { -- UI breadcrumbs bar
        fallthrough = false,
        -- Inactive winbar
        {
          condition = function() return not conditions.is_active() end,
          {
            comp.space(),
            comp.file_icon(),
            comp.file_name(),
          },
        },
        -- Active winbar
        { comp.breadcumbs() },
      },
      statusline = {
        comp.space(),
        comp.mode(),
        comp.space { length = 2 },
        comp.git(),
        comp.space { length = 2 },
        comp.file_name(),
        comp.space(),
        comp.file_path(),
        comp.space(),
        comp.diagnostics(),
        comp.fill(),
        comp.cmd_info(),
        comp.space(),
        comp.codeium(),
        comp.space(),
        comp.cur_pos(),
      },
    }
  end,
}
