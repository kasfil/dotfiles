return {
  "Exafunction/codeium.nvim",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  opts = {
    enable_chat = true,
    enable_cmp_source = false,
    virtual_text = {
      enabled = true,
      default_filetype_enabled = true,
      manual = true,
      map_keys = false,
    },
  },
  config = function(_, opts)
    require("codeium").setup(opts)
    local cvt = require "codeium.virtual_text"

    vim.keymap.set("i", "<M-a>", function()
      if cvt.status().state == "completions" and cvt.status().current then
        return cvt.accept()
      elseif cvt.status().state == "idle" then
        return cvt.complete()
      end
    end, { expr = true, script = true })
  end,
}
