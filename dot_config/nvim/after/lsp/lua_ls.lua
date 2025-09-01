return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = {
        disable = { "missing-fields" },
        globals = { "Snacks", "MiniBufremove", "MiniIcons" },
      },
      hint = {
        enable = true,
        arrayIndex = "Disable",
      },
    },
  },
}
