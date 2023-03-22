return {
  "ray-x/go.nvim",
  dependencies = { "ray-x/guihua.lua" },
  opts = {
    icons = false,
    dap_debug_keymap = false,
    comment_placeholder = " : ",
    lsp_keymap = false,
    luasnip = true,
    test_runner = "ginkgo",
  },
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
}
