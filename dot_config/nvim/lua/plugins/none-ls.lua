-- Customize None-ls sources

---@type LazySpec
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvimtools/none-ls-extras.nvim" },
  opts = function(_, config)
    local null_ls = require "null-ls"
    local helpers = require "null-ls.helpers"
    local b = null_ls.builtins

    local sqlfluff = function()
      return {
        name = "SQLFluff",
        filetypes = { "sql" },
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        generator = helpers.generator_factory {
          command = "sqlfluff",
          args = {
            "lint",
            "--disable-progress-bar",
            "-f",
            "github-annotation",
            "-n",
            "$FILENAME",
          },
          from_stderr = false,
          to_stdin = false,
          to_temp_file = true,
          format = "json",
          check_exit_code = function(c) return c <= 1 end,
          on_output = helpers.diagnostics.from_json {
            attributes = {
              row = "start_line",
              col = "start_column",
              end_row = "end_line",
              end_col = "end_column",
              severity = "annotation_level",
              message = "message",
            },
            severities = {
              helpers.diagnostics.severities["information"],
              helpers.diagnostics.severities["warning"],
              helpers.diagnostics.severities["error"],
              helpers.diagnostics.severities["hint"],
            },
          },
        },
      }
    end

    local revive = function()
      local severities = {
        error = vim.lsp.protocol.DiagnosticSeverity.Error,
        warning = vim.lsp.protocol.DiagnosticSeverity.Warning,
      }

      local config_files = { "revive.toml", ".revive.toml" }
      local revive_config = function()
        for _, name in ipairs(config_files) do
          if vim.fn.filereadable(vim.fn.expand "$PWD/" .. name) == 1 then return vim.fn.expand "$PWD/" .. name end
        end
        return nil
      end

      local args = {}
      if revive_config() ~= nil then table.insert(args, "-config=" .. revive_config()) end

      table.insert(args, "-exclude=vendor/...")
      table.insert(args, "-formatter=json")
      table.insert(args, "$FILENAME")

      return {
        name = "revive",
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        filetypes = { "go" },
        generator = helpers.generator_factory {
          command = "revive",
          args = args,
          check_exit_code = function(code) return code == 1 end,
          multiple_files = false,
          format = "json",
          from_stderr = true,
          to_stdin = false,
          on_output = function(params)
            local diags = {}
            for _, d in ipairs(params.output) do
              table.insert(diags, {
                row = d.Position.Start.Line,
                col = d.Position.Start.Column,
                end_row = d.Position.End.Line,
                end_col = d.Position.End.Column,
                source = "revive",
                message = d.Failure,
                severity = severities[d.Severity],
              })
            end
            return diags
          end,
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
      revive,

      -- json
      require "none-ls.formatting.jq",

      -- lua
      b.formatting.stylua,

      -- sql
      b.formatting.sqlfluff,
      sqlfluff,

      -- rust
      require "none-ls.formatting.rustfmt",
    }
    return config -- return final config table
  end,
}
