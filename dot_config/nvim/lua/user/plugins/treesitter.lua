return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ensure_installed = {
      "bash",
      "vimdoc",
      "comment",
      "gitignore",
      "go",
      "gomod",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "norg",
      "python",
      "sql",
      "toml",
      "vim",
      "yaml",
    }
    opts.highlight = { enable = true }
    opts.indent = {
      enable = true,
      disable = { "python", "yaml" },
    }
    opts.rainbow = {
      enable = false,
    }
    return opts
  end,
}
