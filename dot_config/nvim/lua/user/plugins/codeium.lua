-- official build with vim script
local codeium = {
  "Exafunction/codeium.vim",
  name = "vimcodeium",
  event = { "VimEnter" },
  init = function()
    vim.g.codeium_no_map_tab = true
    vim.g.codeium_filetypes = {
      ["neo-tree-popup"] = false,
      TelescopePrompt = false,
      qf = false,
      help = false,
      quickfix = false,
    }
  end,
  config = function() vim.cmd [[imap <script><silent><nowait><expr> <Plug>(codeium-accept) codeium#Accept()]] end,
}

-- Community plugins build with lua
local nvim_codeium = {
  {
    "Exafunction/codeium.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function() require("codeium").setup {} end,
  },
}

return nvim_codeium
