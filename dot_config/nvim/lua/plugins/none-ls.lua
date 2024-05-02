-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
  opts = function(_, config)
    local null_ls = require "null-ls"
    local helpers = require "null-ls.helpers"
    local b = null_ls.builtins

    local revive = function()
      local revive_config = function()
        if vim.fn.filereadable(vim.fn.expand "$PWD/revive.toml") == 1 then return vim.fn.expand "$PWD/revive.toml" end
        return nil
      end

      local args = { "-set_exit_status" }
      if revive_config() ~= nil then args[#args + 1] = "-config=" .. revive_config() end

      args[#args + 1] = "-exclude=vendor/..."
      args[#args + 1] = "$FILENAME"

      return {
        name = "revive",
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        filetypes = { "go" },
        generator = helpers.generator_factory {
          args = args,

          check_exit_code = function(code) return code < 1 end,
          command = "revive",
          format = "line",
          from_stderr = true,
          on_output = helpers.diagnostics.from_patterns {
            {
              pattern = "([^:]+):(%d+):(%d+):%s(.+)",
              groups = { "path", "row", "col", "message" },
            },
          },
          to_stdin = true,
        },
      }
    end
    config.sources = {
      -- python
      b.formatting.isort,
      b.formatting.black.with {
        cwd = function(params) return vim.fn.fnamemodify(params.bufname, ":h") end,
      },
      require "none-ls.diagnostics.ruff",

      -- go
      b.formatting.goimports,
      b.diagnostics.revive.with {
        args = function()
          local args = {}

          if vim.fn.filereadable(vim.fn.expand "$PWD/revive.toml") == 1 then
            table.insert(args, "-config=$ROOT/revive.toml")
          end

          table.insert(args, "-exclude=vendor/...")
          table.insert(args, "-formatter=json")
          table.insert(args, "./...")

          return args
        end,
      },
      -- revive,

      -- json
      require "none-ls.formatting.jq",

      -- lua
      b.formatting.stylua,

      -- sql
      b.formatting.sqlfluff,
      b.diagnostics.sqlfluff,

      -- rust
      require "none-ls.formatting.rustfmt",
    }
    return config -- return final config table
  end,
}
