return {
  "jose-elias-alvarez/null-ls.nvim",
  opts = function(_, opts)
    local null_ls = require "null-ls"
    local helpers = require "null-ls.helpers"
    local utils = require "null-ls.utils"
    local b = null_ls.builtins

    local revive = function()
      local revive_config = function()
        if vim.fn.filereadable(vim.fn.expand "$PWD/revive.toml") == 1 then
          return vim.fn.expand "$PWD/revive.toml"
        else
          return vim.fn.expand "$HOME/.config/revive/revive.toml"
        end
      end

      return {
        name = "revive",
        method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
        filetypes = { "go" },
        generator = helpers.generator_factory {
          args = {
            "-set_exit_status",
            "-config=" .. revive_config(),
            "-exclude=vendor/...",
            "$FILENAME",
          },

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

    opts.sources = {
      -- python
      b.diagnostics.flake8.with {
        cwd = helpers.cache.by_bufnr(
          function(params)
            return utils.root_pattern("pyproject.toml", ".flake8", "setup.cfg", "tox.ini")(params.bufname)
          end
        ),
      },
      b.diagnostics.mypy.with {
        extra_args = { "--ignore-missing-import" },
      },
      b.formatting.isort,
      b.formatting.black.with {
        cwd = function(params) return vim.fn.fnamemodify(params.bufname, ":h") end,
      },
      -- go
      b.formatting.goimports,
      revive,
      -- json
      b.formatting.jq,
    }
    return opts
  end,
}
