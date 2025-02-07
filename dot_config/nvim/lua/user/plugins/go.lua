return {
  "ray-x/go.nvim",
  dependencies = { -- optional packages
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all()', -- if you need to install/update all binaries
  opts = {
    comment_placeholder = "   ",
    icons = false,
    lsp_cfg = {
      capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      ),
    },
    lsp_keymaps = false,
    lsp_inlay_hints = {
      enable = false,
    },
    dap_debug_keymap = false,
  },
}
