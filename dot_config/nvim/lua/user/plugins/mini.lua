return { -- Collection of various small independent plugins/modules
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    require("mini.icons").setup()
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    require("mini.surround").setup {}

    -- Better Around/Inside textobjects
    require("mini.ai").setup { n_lines = 500 }

    require("mini.align").setup()

    require("mini.bufremove").setup()

    require("mini.jump2d").setup { view = { dim = true } }

    local sessions = {
      { name = "Load session", action = "SessionLoad", section = "Session" },
      { name = "Select session", action = "SessionSelect", section = "Session" },
    }

    local starter = require "mini.starter"
    starter.setup {
      items = {
        sessions,
        starter.sections.builtin_actions(),
        starter.sections.recent_files(3, true, true),
      },
      content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.aligning("center", "center"),
      },
    }
  end,
}
