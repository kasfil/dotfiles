local colors = require("colorscheme.bm").colors
local gl = require("galaxyline")
local glx = gl.section

gl.short_line_list = { "packer", "NvimTree" }

-- Local statusline utils
local buffer_not_empty = function ()
    if vim.fn.empty(vim.fn.expand('%:t')) == 1 then
        return false
    end
    return true
end

local has_width_gt = function (cols)
    return vim.fn.winwidth(0) / 2 > cols
end

local in_git_repo = function ()
  local vcs = require('galaxyline.provider_vcs')
  local branch_name = vcs.get_git_branch()

  return branch_name ~= nil
end

local checkwidth = function()
  return has_width_gt(40) and in_git_repo()
end

local mode_color = function()
  local mode_colors = {
    n = colors.cyan,
    i = colors.green_high,
    c = colors.orange,
    V = colors.purple,
    [''] = colors.purple,
    v = colors.purple,
    R = colors.red,
  }

  local color = mode_colors[vim.fn.mode()]

  if color == nil then
    color = colors.red
  end

  return color
end

-- Left side
glx.left[1] = {
  FirstElement = {
    provider = function() return '▋' end,
    highlight = { colors.cyan, colors.bg_dark }
  },
}
glx.left[2] = {
  ViMode = {
    provider = function()
      local alias = {
        n = 'NORMAL',
        i = 'INSERT',
        c = 'COMMAND',
        V = 'VISUAL',
        [''] = 'VISUAL',
        v = 'VISUAL',
        R = 'REPLACE',
      }
      vim.api.nvim_command('hi GalaxyViMode guifg='..mode_color())
      local alias_mode = alias[vim.fn.mode()]
      if alias_mode == nil then
        alias_mode = vim.fn.mode()
      end
      return alias_mode..'  '
    end,
    separator = "  ",
    highlight = { colors.bg, colors.bg },
    separator_highlight = { colors.bg, colors.bg_dark },
  },
}
glx.left[3] ={
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = { require('galaxyline.provider_fileinfo').get_file_icon_color, colors.bg_dark },
  },
}
glx.left[4] = {
  FileName = {
    provider = 'FileName',
    condition = buffer_not_empty,
    highlight = { colors.fg, colors.bg_dark },
    separator = " ",
    separator_highlight = {colors.bg_dark, colors.bg_dark},
  }
}
glx.left[5] = {
  GitIcon = {
    provider = function() return '  ' end,
    condition = in_git_repo,
    highlight = { colors.orange, colors.bg_dark },
  }
}
glx.left[6] = {
  GitBranch = {
    provider = function()
      local vcs = require('galaxyline.provider_vcs')
      local branch_name = vcs.get_git_branch()
      if (string.len(branch_name) > 28) then
        return string.sub(branch_name, 1, 25).."..."
      end
      return branch_name .. "  "
    end,
    condition = in_git_repo,
    highlight = { colors.fg, colors.bg_dark },
  }
}
glx.left[7] = {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = ' ',
    highlight = { colors.green, colors.bg_dark },
  }
}
glx.left[8] = {
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = ' ',
    highlight = { colors.orange, colors.bg_dark },
  }
}
glx.left[9] = {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = ' ',
    highlight = { colors.red,colors.bg_dark },
  }
}
glx.left[10] = {
  LeftEnd = {
    provider = function() return '  ' end,
    condition = buffer_not_empty,
    highlight = { colors.bg_dark, colors.bg_dark }
  }
}
glx.left[11] = {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = { colors.red, colors.bg_dark }
  }
}
glx.left[12] = {
  Space = {
    provider = function () return ' ' end,
    highlight = { colors.bg_dark, colors.bg_dark },
  }
}
glx.left[13] = {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = { colors.orange, colors.bg_dark },
  }
}
glx.left[14] = {
  Space = {
    provider = function () return ' ' end,
    highlight = { colors.bg_dark, colors.bg_dark },
  }
}
glx.left[15] = {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
    icon = '  ',
    highlight = { colors.blue, colors.bg_dark },
    separator = '  ',
    separator_highlight = { colors.bg_dark, colors.bg_dark },
  }
}

-- Right side
glx.right[1]= {
  FileFormat = {
    provider = function() return vim.bo.filetype end,
    highlight = { colors.fg, colors.bg_dark },
    separator = '  ',
    separator_highlight = { colors.bg_dark, colors.bg_dark },
  }
}
glx.right[2] = {
  LineInfo = {
    provider = 'LineColumn',
    highlight = { colors.fg, colors.bg_dark },
    separator = ' | ',
    separator_highlight = { colors.bg, colors.bg_dark },
  },
}

-- Short status line
glx.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    highlight = { colors.fg, colors.bg },
    separator = '  ',
    separator_highlight = { colors.bg_dark, colors.bg_dark },
  }
}

glx.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = { colors.yellow, colors.bg },
    separator = '  ',
    separator_highlight = { colors.bg_dark, colors.bg },
  }
}

-- Force manual load so that nvim boots with a status line
gl.load_galaxyline()
