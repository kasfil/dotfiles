local aucmd = vim.api.nvim_create_autocmd

local function augroup(name) return vim.api.nvim_create_augroup("user_" .. name, { clear = true }) end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup "checktime",
  callback = function()
    if vim.o.buftype ~= "nofile" then vim.cmd "checktime" end
  end,
})

-- Update buffers when adding new buffers
local bufferline_group = augroup "bufferline"
aucmd({ "BufAdd", "BufEnter", "TabNewEntered" }, {
  desc = "Update buffers when adding new buffers",
  group = bufferline_group,
  callback = function(args)
    if not vim.t.bufs then vim.t.bufs = {} end
    local bufs = vim.t.bufs
    if not vim.tbl_contains(bufs, args.buf) then
      table.insert(bufs, args.buf)
      vim.t.bufs = bufs
    end
    vim.t.bufs = vim.tbl_filter(vim.api.nvim_buf_is_valid, vim.t.bufs)
  end,
})

-- Update buffers when deleting buffers
aucmd("BufDelete", {
  desc = "Update buffers when deleting buffers",
  group = bufferline_group,
  callback = function(args)
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      local bufs = vim.t[tab].bufs
      if bufs then
        for i, bufnr in ipairs(bufs) do
          if bufnr == args.buf then
            table.remove(bufs, i)
            vim.t[tab].bufs = bufs
            break
          end
        end
      end
    end
    vim.t.bufs = vim.tbl_filter(vim.api.nvim_buf_is_valid, vim.t.bufs)
    vim.cmd.redrawtabline()
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup "highlight_yank",
  callback = function() (vim.hl or vim.highlight).on_yank { timeout = 50 } end,
})

-- Resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup "resize_splits",
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd "tabdo wincmd ="
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- Go to last loc when opening a buffer, see ':h last-position-jump'
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup "last_loc",
  callback = function(event)
    local exclude = { "gitcommit", "commit", "gitrebase" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then return end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

-- Close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup "close_with_q",
  pattern = {
    "blame",
    "checkhealth",
    "dbout",
    "fugitive",
    "fugitiveblame",
    "gitsigns-blame",
    "grug-far",
    "help",
    "httpResult",
    "lspinfo",
    "neotest-output",
    "neotest-output-panel",
    "neotest-summary",
    "notify",
    "PlenaryTestPopup",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "dap-float",
    "dap-repl",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.schedule(function()
      vim.keymap.set("n", "q", function()
        vim.cmd "close"
        pcall(_G.MiniBufremove, event.buf)
      end, {
        buffer = event.buf,
        silent = true,
        desc = "Quit buffer",
      })
    end)
  end,
})

-- Show cursor line only in active window
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter" }, {
  group = augroup "auto_cursorline_show",
  callback = function(event)
    if vim.bo[event.buf].buftype == "" then vim.opt_local.cursorline = true end
  end,
})
vim.api.nvim_create_autocmd({ "InsertEnter", "WinLeave" }, {
  group = augroup "auto_cursorline_hide",
  callback = function() vim.opt_local.cursorline = false end,
})

-- Wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup "wrap_spell",
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function() vim.opt_local.spell = true end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup "json_conceal",
  pattern = { "json", "jsonc", "json5" },
  callback = function() vim.opt_local.conceallevel = 0 end,
})

-- Create directories when needed, when saving a file (except for URIs "://").
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup "auto_create_dir",
  callback = function(event)
    if event.match:match "^%w%w+:[\\/][\\/]" then return end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

-- Disable swap/undo/backup files in temp directories or shm
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup "undo_disable",
  pattern = { "/tmp/*", "*.tmp", "*.bak", "COMMIT_EDITMSG", "MERGE_MSG" },
  callback = function(event)
    vim.opt_local.undofile = false
    if event.file == "COMMIT_EDITMSG" or event.file == "MERGE_MSG" then vim.opt_local.swapfile = false end
  end,
})

-- Disable swap/undo/backup files in temp directories or shm
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPre" }, {
  group = augroup "secure",
  pattern = {
    "/tmp/*",
    "$TMPDIR/*",
    "$TMP/*",
    "$TEMP/*",
    "*/shm/*",
    "/private/var/*",
  },
  callback = function()
    vim.opt_local.undofile = false
    vim.opt_local.swapfile = false
    vim.opt_global.backup = false
    vim.opt_global.writebackup = false
  end,
})

aucmd("BufReadPost", {
  group = augroup "restore_cur",
  desc = "Restore cursor to previous position",
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then vim.cmd 'normal! g`"zz' end
  end,
})

aucmd({ "CursorMoved", "CursorMovedI", "WinScrolled" }, {
  desc = "Fix scrolloff when you are at the EOF",
  group = augroup "ScrollEOF",
  callback = function()
    if vim.api.nvim_win_get_config(0).relative ~= "" then
      return -- Ignore floating windows
    end

    local win_height = vim.fn.winheight(0)
    local scrolloff = math.min(vim.o.scrolloff, math.floor(win_height / 2))
    local visual_distance_to_eof = win_height - vim.fn.winline()

    if visual_distance_to_eof < scrolloff then
      local win_view = vim.fn.winsaveview()
      vim.fn.winrestview { topline = win_view.topline + scrolloff - visual_distance_to_eof }
    end
  end,
})

aucmd("ColorScheme", {
  pattern = "gruvbox-material",
  callback = function()
    local cfg = vim.fn["gruvbox_material#get_configuration"]()
    local apply_hl = require("user.utils").apply_hl

    local palette = {}
    for group, colors in
      pairs(vim.fn["gruvbox_material#get_palette"](cfg.background, cfg.foreground, cfg.colors_override))
    do
      palette[group] = colors[1]
    end

    local custom_hl = {
      CodeiumSuggestion = { fg = palette.bg5, bg = palette.none, italic = true },
      InlayHints = { fg = palette.bg4, bg = palette.none, italic = true },
      FoldColumn = { fg = palette.bg4, bg = palette.none },
      CursorLineFold = { fg = palette.bg4, bg = palette.none, nocombine = true, force = true },
      CursorLineNr = { fg = palette.green, bg = palette.none },
      CursorLine = { fg = palette.none, bg = palette.none },
      SideWin = { fg = palette.fg0, bg = palette.bg_dim },
      Comment = { fg = palette.bg5, italic = true },

      -- Buffer and Tabline
      TabLine = { fg = palette.none, bg = palette.bg_dim },
      BufferActive = { fg = palette.fg0, bg = palette.bg_statusline2, bold = true },
      BufferActiveSep = { fg = palette.blue, bg = palette.bg_statusline2 },
      BufferInactive = { fg = palette.bg5, bg = palette.bg0 },
      BufferInactiveSep = { fg = palette.bg_dim, bg = palette.bg0 },
      TabLineFill = { link = "TabLine" },

      -- Indent
      IblIndent = { fg = palette.bg1, bg = palette.none },
      IblScope = { fg = palette.bg_visual_yellow, bg = palette.none },

      -- winbar
      Winbar = { fg = palette.fg0, bg = palette.bg2 },

      -- treesitter-context
      TreesitterContext = { fg = palette.fg0, bg = palette.bg1 },
      TreesitterContextLineNumber = { fg = palette.bg5, bg = palette.bg1 },

      -- navic
      NavicIconsFile = { bg = palette.bg_statusline1, inherit = "NavicIconsFile" },
      NavicIconsModule = { bg = palette.bg_statusline1, inherit = "NavicIconsModule" },
      NavicIconsNamespace = { bg = palette.bg_statusline1, inherit = "NavicIconsNamespace" },
      NavicIconsPackage = { bg = palette.bg_statusline1, inherit = "NavicIconsPackage" },
      NavicIconsClass = { bg = palette.bg_statusline1, inherit = "NavicIconsClass" },
      NavicIconsMethod = { bg = palette.bg_statusline1, inherit = "NavicIconsMethod" },
      NavicIconsProperty = { bg = palette.bg_statusline1, inherit = "NavicIconsProperty" },
      NavicIconsField = { bg = palette.bg_statusline1, inherit = "NavicIconsField" },
      NavicIconsConstructor = { bg = palette.bg_statusline1, inherit = "NavicIconsConstructor" },
      NavicIconsEnum = { bg = palette.bg_statusline1, inherit = "NavicIconsEnum" },
      NavicIconsInterface = { bg = palette.bg_statusline1, inherit = "NavicIconsInterface" },
      NavicIconsFunction = { bg = palette.bg_statusline1, inherit = "NavicIconsFunction" },
      NavicIconsVariable = { bg = palette.bg_statusline1, inherit = "NavicIconsVariable" },
      NavicIconsConstant = { bg = palette.bg_statusline1, inherit = "NavicIconsConstant" },
      NavicIconsString = { bg = palette.bg_statusline1, inherit = "NavicIconsString" },
      NavicIconsNumber = { bg = palette.bg_statusline1, inherit = "NavicIconsNumber" },
      NavicIconsBoolean = { bg = palette.bg_statusline1, inherit = "NavicIconsBoolean" },
      NavicIconsArray = { bg = palette.bg_statusline1, inherit = "NavicIconsArray" },
      NavicIconsObject = { bg = palette.bg_statusline1, inherit = "NavicIconsObject" },
      NavicIconsKey = { bg = palette.bg_statusline1, inherit = "NavicIconsKey" },
      NavicIconsNull = { bg = palette.bg_statusline1, inherit = "NavicIconsNull" },
      NavicIconsEnumMember = { bg = palette.bg_statusline1, inherit = "NavicIconsEnumMember" },
      NavicIconsStruct = { bg = palette.bg_statusline1, inherit = "NavicIconsStruct" },
      NavicIconsEvent = { bg = palette.bg_statusline1, inherit = "NavicIconsEvent" },
      NavicIconsOperator = { bg = palette.bg_statusline1, inherit = "NavicIconsOperator" },
      NavicIconsTypeParameter = { bg = palette.bg_statusline1, inherit = "NavicIconsTypeParameter" },
      NavicText = { bg = palette.bg_statusline1, inherit = "NavicText" },
      NavicSeparator = { bg = palette.bg_statusline1, inherit = "NavicSeparator" },

      -- grugfar
      GrugFarResultsMatch = { bg = palette.bg_visual_green, fg = palette.none },
      GrugFarResultsMatchAdded = { bg = palette.bg_visual_yellow, fg = palette.none },
      GrugFarResultsMatchRemoved = { bg = palette.bg_visual_red, fg = palette.none },

      -- Dap-nvim
      DapBreakpoint = { fg = palette.red },
      DapLogPoint = { fg = palette.yellow },
      DapStopped = { fg = palette.green },

      -- Telescope
      TelescopePromptPrefix = { fg = palette.red, bg = palette.bg1 },
      TelescopeNormal = { bg = palette.bg1 },
      TelescopeBorder = { bg = palette.bg1, fg = palette.bg1 },
      TelescopeTitle = { bg = palette.yellow, fg = palette.bg1 },
      TelescopeSelection = { bg = palette.bg0, fg = palette.fg0, bold = true },
      TelescopeMultiIcon = { bg = palette.none, fg = palette.green },
      TelescopeMultiSelection = { bg = palette.none, fg = palette.yellow, bold = true },
      TelescopePreviewNormal = { bg = palette.bg_dim },
      TelescopePreviewBorder = { bg = palette.bg_dim, fg = palette.bg_dim },

      -- Lspsaga
      SagaTitle = { bg = palette.bg_dim, fg = palette.orange },
      SagaBorder = { bg = palette.bg_dim, fg = palette.bg_dim },
      RenameNormal = { link = "NormalFloat" },
      OutlineNormal = { link = "SideWin" },

      -- cmp nvim
      CmpFloatBorder = { bg = palette.bg_dim, fg = palette.bg_dim },
    }

    for k, v in pairs(custom_hl) do
      apply_hl(k, v)
    end
  end,
})
