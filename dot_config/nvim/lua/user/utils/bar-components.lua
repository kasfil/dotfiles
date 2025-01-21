local C = {}
local utils = require "heirline.utils"
local conditions = require "heirline.conditions"
local get_hl = utils.get_highlight
local get_icon = require("user.utils").get_icon

local extend_opts = function(base, extender)
  extender = extender or {}
  return vim.tbl_extend("force", base, extender)
end

---unique path feeder
local path_feeder = function(bufnr)
  local parts = {}
  for match in (vim.api.nvim_buf_get_name(bufnr) .. "/"):gmatch("(.-)" .. "/") do
    table.insert(parts, match)
  end

  return parts
end

---Single space component
C.space = function(opts)
  opts = opts or {}
  local length = opts.length or 1

  return extend_opts({ provider = string.rep(" ", length) }, opts)
end

---Vim extender component
C.fill = function()
  return { provider = "%=" }
end

---Vim mode component
C.mode = function(opts)
  return extend_opts({
    init = function(self)
      self.mode = vim.fn.mode()
    end,
    static = {
      mode_name = setmetatable({
        ["n"] = "NORMAL",
        ["no"] = "O-PENDING",
        ["nov"] = "O-PENDING",
        ["noV"] = "O-PENDING",
        ["no\22"] = "O-PENDING",
        ["niI"] = "NORMAL",
        ["niR"] = "NORMAL",
        ["niV"] = "NORMAL",
        ["nt"] = "NORMAL",
        ["ntT"] = "NORMAL",
        ["v"] = "VISUAL",
        ["vs"] = "VISUAL",
        ["V"] = "V-LINE",
        ["Vs"] = "V-LINE",
        ["\22"] = "V-BLOCK",
        ["\22s"] = "V-BLOCK",
        ["s"] = "SELECT",
        ["S"] = "S-LINE",
        ["\19"] = "S-BLOCK",
        ["i"] = "INSERT",
        ["ic"] = "INSERT",
        ["ix"] = "INSERT",
        ["R"] = "REPLACE",
        ["Rc"] = "REPLACE",
        ["Rx"] = "REPLACE",
        ["Rv"] = "V-REPLACE",
        ["Rvc"] = "V-REPLACE",
        ["Rvx"] = "V-REPLACE",
        ["c"] = "COMMAND",
        ["cv"] = "EX",
        ["ce"] = "EX",
        ["r"] = "REPLACE",
        ["rm"] = "MORE",
        ["r?"] = "CONFIRM",
        ["!"] = "SHELL",
        ["t"] = "TERMINAL",
      }, {
        __index = function()
          return "OTHER"
        end,
      }),
    },
    provider = function(self)
      return "[" .. self.mode_name[vim.fn.mode()] .. "]"
    end,
    update = {
      "ModeChanged",
      pattern = "*:*",
      callback = vim.schedule_wrap(function()
        vim.cmd.redrawstatus()
      end),
    },
  }, opts)
end

---File icon component
C.file_icon = function(opts)
  return extend_opts({
    init = function(self)
      local filename = vim.api.nvim_buf_get_name(self.bufnr or 0)
      ---@diagnostic disable-next-line: undefined-global
      self.icon, self.icon_color, _ = MiniIcons.get("file", vim.fn.fnamemodify(filename, ":p:t"))
    end,
    provider = function(self)
      return self.icon and (self.icon .. " ")
    end,
    hl = function(self)
      return self.icon_color
    end,
  }, opts)
end

--- File name component
C.file_name = function(opts)
  return extend_opts({
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
    end,
    provider = function(self)
      return vim.fn.fnamemodify(self.filename, ":p:t")
    end,
  }, opts)
end

--- Buffer diagnostics component
C.diagnostics = function(opts)
  return extend_opts({
    condition = conditions.has_diagnostics,
    update = { "DiagnosticChanged", "BufEnter" },
    static = {
      err_icon = get_icon "error_sign" .. " ",
      warn_icon = get_icon "warning_sign" .. " ",
      hint_icon = get_icon "hint_sign" .. " ",
      info_icon = get_icon "info_sign" .. " ",
    },
    init = function(self)
      self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,
    { provider = " " },
    {
      provider = function(self)
        return self.errors > 0 and (self.err_icon .. self.errors .. " ")
      end,
      hl = "DiagnosticError",
    },
    {
      provider = function(self)
        return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
      end,
      hl = "DiagnosticWarn",
    },
    {
      provider = function(self)
        return self.info > 0 and (self.info_icon .. self.info .. " ")
      end,
      hl = "DiagnosticInfo",
    },
    {
      provider = function(self)
        return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
      end,
      hl = "DiagnosticHint",
    },
  }, opts)
end

--- Buffer git status
C.git = function(opts)
  return extend_opts({
    condition = conditions.is_git_repo,
    init = function(self)
      self.status =
        vim.tbl_extend("force", { head = "", added = 0, changed = 0, removed = 0 }, vim.b.gitsigns_status_dict)
      self.modified = self.status.added ~= 0 or self.status.changed ~= 0 or self.status.removed ~= 0
    end,
    {
      provider = " " .. get_icon "git_branch" .. " ",
      hl = "BlueSign",
    },
    {
      provider = function(self)
        return self.status.head
      end,
    },
    {
      condition = function(self)
        return self.modified
      end,
      provider = " [",
    },
    {
      condition = function(self)
        return self.status.added ~= 0
      end,
      provider = function(self)
        return "+" .. self.status.added
      end,
      hl = "GitSignsAdd",
    },
    {
      condition = function(self)
        return self.status.changed ~= 0
      end,
      provider = function(self)
        return "~" .. self.status.changed
      end,
      hl = "GitSignsChange",
    },
    {
      condition = function(self)
        return self.status.removed ~= 0
      end,
      provider = function(self)
        return "-" .. self.status.removed
      end,
      hl = "GitSignsDelete",
    },
    {
      condition = function(self)
        return self.modified
      end,
      provider = "]",
    },
  }, opts)
end

C.cmd_info = function(opts)
  return extend_opts({
    condition = function()
      return vim.fn.reg_recording() ~= "" or vim.v.hlsearch ~= 0
    end,
    {
      condition = function()
        return vim.fn.reg_recording() ~= ""
      end,
      hl = "RedBold",
      provider = function()
        local register = vim.fn.reg_recording()
        if register == "" then
          return
        end

        return " Rec: " .. register
      end,
      update = {
        "RecordingEnter",
        "RecordingLeave",
        callback = vim.schedule_wrap(function()
          vim.cmd.redrawstatus()
        end),
      },
    },
    {
      condition = function()
        return vim.v.hlsearch ~= 0
      end,
      hl = "YellowBold",
      provider = function()
        local search_func = vim.tbl_isempty(opts or {}) and function()
          return vim.fn.searchcount()
        end or function()
          return vim.fn.searchcount(opts)
        end

        local search_ok, search = pcall(search_func)
        if search_ok and type(search) == "table" and search.total then
          return string.format(
            " 󰱼 %s%d/%s%d",
            search.current > search.maxcount and ">" or "",
            math.min(search.current, search.maxcount),
            search.incomplete == 2 and ">" or "",
            math.min(search.total, search.maxcount)
          )
        end
      end,
    },
  }, opts)
end

C.codeium = function()
  return {
    hl = "GreenBold",
    condition = function()
      local ok, _ = pcall(require, "codeium")
      return ok
    end,
    provider = function()
      local cvt = require "codeium.virtual_text"
      local status = cvt.status()
      local text = "0"

      cvt.set_statusbar_refresh(function()
        vim.cmd.redrawstatus()
      end)

      if status.state == "idle" then
        text = "idle"
      elseif status.state == "waiting" then
        text = "thinking"
      elseif status.state == "completions" and status.total > 0 then
        text = string.format("%d / %d", status.current, status.total)
      end

      return " " .. text
    end,
  }
end

---Unique path for buffer list
---@param bufnr integer buf number
---@return string
C.unique_path = function(bufnr)
  local max_length = 16
  local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t") or ""
  local unique_path = ""
  local current

  if not vim.api.nvim_buf_is_valid(bufnr) or name == "" then
    return name
  end

  for _, value in ipairs(vim.t.bufs or {}) do
    if name == vim.fn.fnamemodify(vim.api.nvim_buf_get_name(value), ":t") and value ~= bufnr then
      if not current then
        current = path_feeder(bufnr)
      end
      local other = path_feeder(value)

      for i = #current - 1, 1, -1 do
        if current[i] ~= other[i] then
          unique_path = current[i] .. "/"
          break
        end
      end
    end
  end

  if #unique_path > max_length then
    return string.sub(unique_path, 1, max_length - 2) .. get_icon "elipsis"
  end

  return unique_path
end

--- Cursor position component
C.cur_pos = function(opts)
  return extend_opts({
    update = { "CursorMoved" },
    provider = " %3l:%c ",
  }, opts)
end

--- Winbar breadcumbs component
C.breadcumbs = function(opts)
  return extend_opts({
    condition = function(_)
      local ok, navic = pcall(require, "nvim-navic")
      return ok and navic.is_available()
    end,
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
      self.location = require("nvim-navic").get_location { highlight = true }
    end,
    utils.insert(
      C.space(),
      C.file_icon {
        hl = function(self)
          return { fg = get_hl(self.icon_color).fg, bg = utils.get_highlight("WinBar").bg }
        end,
      },
      C.file_name { hl = "NavicText" },
      {
        provider = get_icon "telescope_select_caret",
        condition = function(self)
          return self.location and self.location ~= ""
        end,
        hl = "NavicSeparator",
      },
      {
        provider = function(self)
          return self.location
        end,
      }
    ),
  }, opts)
end

---tabline picker indicator
C.tab_file_picker = function(opts)
  return extend_opts({
    condition = function(self)
      return self._show_picker
    end,
    init = function(self)
      local bufname = vim.api.nvim_buf_get_name(self.bufnr)
      bufname = vim.fn.fnamemodify(bufname, ":t")
      local label = bufname:sub(1, 1)
      local i = 2
      while self._picker_labels[label] do
        if i > #bufname then
          break
        end
        label = bufname:sub(i, i)
        i = i + 1
      end
      self._picker_labels[label] = self.bufnr
      self.label = label
    end,
    provider = function(self)
      return self.label .. " "
    end,
    hl = "RedBold",
  }, opts)
end

---Close button tabline component
C.tab_close_indicator = function(opts)
  return extend_opts({
    init = function(self)
      self.modified = vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
    end,
    provider = function(self)
      local icon = get_icon "close_btn"
      if self.modified then
        icon = get_icon "modified"
      end

      return icon .. " "
    end,
    hl = function(self)
      if self.modified then
        return "YellowSign"
      elseif self.is_active or self.is_visible then
        return "RedSign"
      else
        return "Grey"
      end
    end,
    on_click = {
      callback = function(_, minwid)
        vim.schedule(function()
          MiniBufremove.delete(minwid, false)
          vim.cmd.redrawtabline()
        end)
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = "heirline_tabline_close_buffer_callback",
    },
  }, opts)
end

--- Tab file block
C.tabfiles = function(opts)
  opts = opts or {}
  -- Min text length in buf name
  local min_length = opts.min_length or 20

  return utils.make_buflist({
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(self.bufnr)
      self.left_pad, self.right_pad = 1, 1
      self.buf_text = C.unique_path(self.bufnr) .. vim.fn.fnamemodify(self.filename, ":p:t")
      -- Get remaining space from text buf
      local remains = min_length - (#self.buf_text + 2)
      -- only defide space if remaining space is more than 2
      if remains > 2 then
        self.left_pad = math.floor(remains / 2)
        self.right_pad = math.ceil(remains / 2)
      end
    end,
    condition = function(self)
      return vim.api.nvim_buf_is_valid(self.bufnr) and vim.bo[self.bufnr].buflisted
    end,
    hl = function(self)
      if self.is_active or self.is_visible then
        return "BufferActiveSep"
      end
      return "BufferInactiveSep"
    end,
    utils.insert(
      {
        provider = "▎",
        on_click = {
          callback = function(_, minwid, _, btn)
            if btn == "m" then
              vim.schedule(function()
                ---@diagnostic disable-next-line: undefined-field
                _G.MiniBufremove.delete(minwid, false)
                vim.cmd.redrawtabline()
              end)
            else
              vim.api.nvim_win_set_buf(0, minwid)
            end
          end,
          minwid = function(self)
            return self.bufnr
          end,
          name = "heirline_tabline_close_buffer_callback",
        },
      },
      {
        provider = function(self)
          return string.rep(" ", self.left_pad)
        end,
      },
      C.file_icon {
        condition = function(self)
          return not self._show_picker
        end,
        hl = function(self)
          if self.is_active or self.is_visible then
            return self.icon_color
          else
            return "Grey"
          end
        end,
      },
      C.tab_file_picker(),
      {
        provider = function(self)
          return self.buf_text
        end,
        hl = function(self)
          local fg = get_hl("Grey").fg
          local bold = false
          if self.is_active or self.is_visible then
            fg = get_hl("Fg").fg
            bold = true
          end
          return { fg = fg, bold = bold }
        end,
      },
      {
        provider = function(self)
          return string.rep(" ", self.right_pad)
        end,
      }
    ),
    C.tab_close_indicator(),
  }, { provider = "", hl = "Grey" }, { provider = "", hl = "Grey" })
end

---Tabline conditional padding
C.tabline_padding = function()
  return {
    condition = function(self)
      self.winid = vim.api.nvim_tabpage_list_wins(0)[1]
      local bufnr = vim.api.nvim_win_get_buf(self.winid)

      if vim.bo[bufnr].filetype == "neo-tree" then
        self.title = "NeoTree"
        return true
      elseif vim.bo[bufnr].filetype == "dap-repl" then
        self.title = "Dap Repl"
        return true
      elseif vim.bo[bufnr].filetype == "aerial" then
        self.title = "Aerial"
        return true
      end

      return false
    end,
    provider = function(self)
      local title = self.title or ""
      local width = vim.api.nvim_win_get_width(self.winid)
      local pad = math.ceil((width - #title) / 2)
      return string.rep(" ", pad) .. title .. string.rep(" ", pad)
    end,
    hl = "SideWin",
  }
end

C.tabnu = function()
  local tabpage = {
    provider = function(self)
      return "%" .. self.tabnr .. "T " .. self.tabpage .. " %T"
    end,
    hl = function(self)
      if self.is_active then
        return "BufferActive"
      end
      return "BufferInactive"
    end,
  }

  return {
    condition = function()
      return #vim.api.nvim_list_tabpages() > 1
    end,
    utils.make_tablist(tabpage),
  }
end

return C
