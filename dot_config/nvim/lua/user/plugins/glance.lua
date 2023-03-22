return {
  "DNLHC/glance.nvim",
  keys = {
    { "<leader>lpd", "<CMD>Glance definitions<CR>", desc = "Peek definitions" },
    { "<leader>lpr", "<CMD>Glance references<CR>", desc = "Peek references" },
    { "<leader>lpy", "<CMD>Glance type_definitions<CR>", desc = "Peek type definitions" },
    { "<leader>lpm", "<CMD>Glance implementations<CR>", desc = "Peek implementations" },
  },
  opts = {
    preview_win_opts = {
      wrap = false,
    },
  },
}
