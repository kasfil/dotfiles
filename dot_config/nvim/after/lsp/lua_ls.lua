return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      diagnostics = { disable = { "missing-fields" }, globals = { "Snacks" } },
      hint = {
        enable = true,
        arrayIndex = "Disable",
      },
    },
  },
}
