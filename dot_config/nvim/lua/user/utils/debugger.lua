local M = {}

M.set_breakpoint = function()
  local dap = require "dap"
  local Menu = require "nui.menu"

  local break_menu = Menu({
    position = {
      row = 0,
      col = 2,
    },
    relative = "cursor",
    size = {
      width = 15,
      height = 1,
    },
    border = {
      style = "single",
      text = {
        top = "Breakpoint Type",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
      cursorline = false,
    },
  }, {
    lines = {
      Menu.item("Condition", { id = 1 }),
      Menu.item("Hit Condition", { id = 2 }),
      Menu.item("Log Message", { id = 3 }),
    },
    keymap = {
      focus_next = { "j" },
      focus_prev = { "k" },
      close = { "<ESC>" },
      submit = { "<CR>" },
    },
    on_submit = function(item)
      local args = { nil, nil, nil }

      Snacks.input({
        icon = " ",
        prompt = item.text,
        win = {
          border = "single",
          width = 80,
          relative = "cursor",
          row = -1,
          col = 2,
        },
      }, function(value)
        args[item.id] = value
        dap.set_breakpoint(args[1], args[2], args[3])
      end)
    end,
  })

  return break_menu
end

return M
