return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5", -- Recommended
    ft = { "rust", "rs" },
    init = function()
      vim.g.rustaceanvim = {
        tools = {
          code_actions = {
            group_icon = require("user.utils").get_icon "telescope_select_caret",
          },
        },
      }
    end,
    lazy = false,
  },
  {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      local crates = require "crates"
      crates.setup {
        popup = {
          autofocus = true,
          border = "single",
        },
        on_attach = function(bufnr)
          local desc_prefix = "Cargo: "
          local map_prefix = "<leader>c"
          local mapping = {
            n = {
              { "S", crates.upgrade_all_crates, "Upgrade all" },
              { "s", crates.upgrade_crate, "Upgrade" },
              { "U", crates.update_all_crates, "Update all" },
              { "u", crates.update_crate, "Update" },
              { "d", crates.open_documentation, "Open documentation" },
              { "i", crates.show_crate_popup, "Show crates info" },
              { "v", crates.show_versions_popup, "Show versions" },
              { "f", crates.show_features_popup, "Show features" },
            },
            x = {
              { "s", crates.upgrade_crates, "Upgrade" },
              { "u", crates.update_crates, "Update" },
            },
          }
          local wk_format = {
            { "<leader>c", group = "Cargo", icon = require("user.utils").get_icon "package", buffer = bufnr },
          }

          for mode, maps in pairs(mapping) do
            for _, map in ipairs(maps) do
              table.insert(wk_format, {
                map_prefix .. map[1],
                function() map[2]() end,
                desc = desc_prefix .. map[3],
                mode = mode,
                buffer = bufnr,
              })
            end
          end

          require("which-key").add(wk_format)
        end,
      }
      -- Include crates in cmp completion source
      require("crates.completion.cmp").setup()
    end,
  },
}
