require "user.config.global"
require "user.config.option"
require "user.config.setup"
require "user.config.mapping"
require "user.config.autocmd"
-- include neovide additional config
if vim.g.neovide then require "user.config.neovide" end

vim.filetype.add {
  filename = {
    ["Procfile"] = "sh",
  },
}
