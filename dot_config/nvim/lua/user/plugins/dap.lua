return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {

      "mfussenegger/nvim-dap-python",
      {
        "leoluz/nvim-dap-go",
        config = function(_, _)
          require("dap-go").setup {
            dap_configurations = {
              {
                name = "Run Main",
                type = "go",
                request = "launch",
                program = "${workspaceFolder}/main.go",
              },
            },
          }
        end,
      },
      {
        "Joakker/lua-json5",
        build = "./install.sh",
      },
    },
    config = function(_, _)
      local dap = require "dap"
      local pydap = require "dap-python"

      require("dap.ext.vscode").json_decode = require("json5").parse
      require("dap.ext.vscode").load_launchjs()

      -- setup python dap adapter
      pydap.setup "python"
      pydap.test_runner = "pytest"

      table.insert(dap.configurations.python, {
        name = "Spawn file",
        type = "python",
        request = "launch",
        console = "integratedTerminal",
        program = function()
          local app = vim.fn.input { prompt = "filename: " }
          return "${workspaceFolder}/" .. app
        end,
        args = function()
          local args_string = vim.fn.input { prompt = "Arguments: " }
          return vim.split(args_string, " ")
        end,
      })

      table.insert(dap.configurations.python, {
        name = "Uvicorn",
        type = "python",
        request = "launch",
        console = "integratedTerminal",
        module = "uvicorn",
        subProcess = false,
        args = function()
          local args_string = vim.fn.input { prompt = "Arguments: " }
          return vim.split(args_string, " ")
        end,
      })

      table.insert(dap.configurations.python, {
        name = "Django",
        type = "python",
        request = "launch",
        console = "integratedTerminal",
        program = vim.fn.getcwd() .. "/manage.py",
        args = { "runserver", "--noreload" },
      })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function(plugin, opts)
      require "plugins.configs.nvim-dap-ui"(plugin, opts)

      -- disable dap events that are created
      local dap = require "dap"
      dap.listeners.after.event_initialized["dapui_config"] = nil
      dap.listeners.before.event_terminated["dapui_config"] = nil
      dap.listeners.before.event_exited["dapui_config"] = nil
    end,
  },
}
