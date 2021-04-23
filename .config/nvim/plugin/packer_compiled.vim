" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/kasf/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/kasf/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/kasf/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/kasf/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/kasf/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  ["barbar.nvim"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/barbar.nvim"
  },
  ["colorbuddy.nvim"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/colorbuddy.nvim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  ["gina.vim"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/gina.vim"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["indent-guides.nvim"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/indent-guides.nvim"
  },
  ["lexima.vim"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/lexima.vim"
  },
  nordbuddy = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/nordbuddy"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-hardline"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/nvim-hardline"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  tcomment_vim = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/tcomment_vim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/vim-floaterm"
  },
  ["vim-python-pep8-indent"] = {
    loaded = false,
    needs_bufread = false,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/opt/vim-python-pep8-indent"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/kasf/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  }
}

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
vim.cmd [[au FileType python ++once lua require("packer.load")({'vim-python-pep8-indent'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd("augroup END")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
