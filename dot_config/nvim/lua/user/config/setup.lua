local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local opts = {
  performance = {
    rtp = {
      disabled_plugins = {
        "2html",
        "gzip",
        "remote_plugins",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "netrw",
        "netrwPlugin",
      },
    },
  },
  install = {
    colorscheme = { "gruvbox-material" },
  },
  ui = {
    border = "none",
    title = "Lazy",
  },
}

require("lazy").setup("user.plugins", opts)
vim.notify = require "notify"
