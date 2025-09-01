---@type LazySpec
return {
  "saghen/blink.cmp",
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "default" },
    appearance = {
      nerd_font_variant = "normal",
    },
    completion = {
      documentation = { auto_show = true },
      ghost_text = { enabled = true },
      accept = { auto_brackets = { enabled = true } },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      per_filetype = {
        sql = { "dadbod" },
        lua = { inherit_defaults = true, "lazydev" },
      },
      providers = {
        dadbod = { module = "vim_dadbod_completion.blink" },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
