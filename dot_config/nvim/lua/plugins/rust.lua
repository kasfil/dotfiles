return {
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml", "BufRead Cargo.lock" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- null_ls = {
      --   enabled = true,
      --   name = "Crates",
      -- },
      on_attach = function(bufnr)
        local crates = require "crates"
        local opts = function(desc) return { silent = true, buffer = bufnr, desc = desc } end

        vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts "Show version popup")
        vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts "Show feature popup")
        vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts "Show dependencies popup")

        vim.keymap.set("n", "<leader>cu", crates.update_crate, opts "Update crate")
        vim.keymap.set("v", "<leader>cu", crates.update_crates, opts "Update crates")
        vim.keymap.set("n", "<leader>ca", crates.update_all_crates, opts "Update all crates")
        vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, opts "Upgrade crate")
        vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, opts "Upgrade crates")
        vim.keymap.set("n", "<leader>cA", crates.upgrade_all_crates, opts "Upgrade all crates")
      end,

      src = {},
    },
  },
}
