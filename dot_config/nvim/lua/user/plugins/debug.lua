return {
  "mfussenegger/nvim-dap",
  version = "*",
  event = "VeryLazy",
  dependencies = {
    -- Creates a beautiful debugger UI
    "rcarriga/nvim-dap-ui",

    -- Required dependency for nvim-dap-ui
    "nvim-neotest/nvim-nio",

    -- Add your own debuggers here
    "leoluz/nvim-dap-go",
    "mfussenegger/nvim-dap-python",

    -- Json5 Support
    { "Joakker/lua-json5", build = "./install.sh" },
  },
  config = function()
    local dap = require "dap"
    local dapui = require "dapui"
    local widgets = require "dap.ui.widgets"
    local get_icon = require("user.utils").get_icon

    -- enable json5 support
    require("dap.ext.vscode").json_decode = require("json5").parse

    vim.fn.sign_define("DapBreakpoint", {
      text = get_icon "dap_breakpoint",
      texthl = "DapBreakpoint",
    })
    vim.fn.sign_define("DapBreakpointCondition", {
      text = get_icon "dap_breakpoint_condition",
      texthl = "DapBreakpoint",
    })
    vim.fn.sign_define("DapBreakpointRejected", {
      text = get_icon "dap_breakpoint_rejected",
      texthl = "DapBreakpoint",
    })
    vim.fn.sign_define("DapLogPoint", {
      text = get_icon "dap_logpoint",
      texthl = "DapLogPoint",
    })
    vim.fn.sign_define("DapStopped", {
      text = get_icon "dap_active_frame",
      texthl = "DapStopped",
    })

    local default_winopts = {
      number = false,
      relativenumber = false,
      cursorline = false,
      winbar = "",
      height = 10,
    }

    require("which-key").add {
      mode = "n",
      {
        "<leader>d",
        group = "Debug",
        icon = " ",
      },
      {
        "<F5>",
        function() dap.continue() end,
        desc = "Start / Continue",
      },
      {
        "<F1>",
        function() dap.step_into() end,
        desc = "Step into",
      },
      {
        "<F2>",
        function() dap.step_over() end,
        desc = "Step over",
      },
      {
        "<F3>",
        function() dap.step_out() end,
        desc = "Step out",
      },
      {
        "<F7>",
        function() dapui.toggle() end,
        desc = "Toggle UI",
      },
      {
        "<leader>db",
        function() dap.toggle_breakpoint() end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dB",
        function()
          local menu = require("user.utils.debugger").set_breakpoint()
          menu:mount()
        end,
        desc = "Set breakpoint",
      },
      {
        "<leader>dC",
        function() dap.clear_breakpoints() end,
        desc = "Clear breakpoint",
      },
      {
        mode = { "n", "v" },
        "<leader>dh",
        function() widgets.hover() end,
        desc = "Hover variable",
      },
      {
        mode = { "n", "v" },
        "<leader>dp",
        function() widgets.preview() end,
        desc = "Preview",
      },
      {
        mode = { "n", "v" },
        "<leader>de",
        function() require("dapui").eval() end,
        desc = "Debug evaluate",
      },
      { mode = "n", "<leader>du", group = "Window" },
      {
        mode = "n",
        "<leader>dur",
        function() dap.repl.toggle(default_winopts) end,
        desc = "REPL Toggle",
      },
      {
        "<leader>duv",
        function() widgets.centered_float(widgets.scopes) end,
        desc = "Open scopes",
      },
      {
        "<leader>dus",
        function() widgets.centered_float(widgets.sessions) end,
        desc = "Open sessions",
      },
      {
        "<leader>duf",
        function() widgets.centered_float(widgets.frames) end,
        desc = "Open frames",
      },
      {
        "<leader>due",
        function() widgets.centered_float(widgets.expression) end,
        desc = "Open expression",
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = "", collapsed = "", current_frame = "*" },
      controls = {
        icons = {
          pause = "",
          play = "",
          step_into = "",
          step_over = "",
          step_out = "",
          step_back = "",
          run_last = "",
          terminate = "",
          disconnect = "",
        },
      },
    }

    require("dap-python").setup "python"

    -- Install golang specific config
    require("dap-go").setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has "win32" == 0,
      },
    }
  end,
}
