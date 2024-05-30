---@type AstroCoreOpts
local opts = { -- Configure core features of AstroNvim
  features = {
    large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
    autopairs = true, -- enable autopairs at start
    cmp = true, -- enable completion at start
    diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
    highlighturl = true, -- highlight URLs at start
    notifications = true, -- enable notifications at start
  },
  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = {
      severity = vim.diagnostic.severity.WARN,
      spacing = 2,
      prefix = "󰁎 ",
    },
    underline = true,
  },
  -- vim options can be configured here
  options = {
    opt = { -- vim.opt.<key>
      relativenumber = true, -- sets vim.opt.relativenumber
      number = true, -- sets vim.opt.number
      spell = false, -- sets vim.opt.spell
      signcolumn = "yes", -- sets vim.opt.signcolumn to auto
      wrap = false, -- sets vim.opt.wrap
      updatetime = 250,
      list = true,
      scrolloff = 7,
      tabstop = 4,
      sidescrolloff = 10,
      listchars = {
        tab = "»·",
        nbsp = "+",
        trail = "·",
        extends = "🡆",
        precedes = "🡄",
        eol = "⮧",
      },
      fillchars = {
        eob = " ",
        horiz = "━",
        horizup = "┻",
        horizdown = "┳",
        vert = "┃",
        vertleft = "┫",
        vertright = "┣",
        verthoriz = "╋",
        diff = "╱",
        foldopen = "",
        foldclose = "",
        fold = " ",
        msgsep = "-",
      },
      cot = { "menu", "menuone", "noselect", "noinsert" },
      exrc = true,
    },
    g = {
      autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
      cmp_enabled = true, -- enable completion at start
      autopairs_enabled = true, -- enable autopairs at start
      lsp_handlers_enabled = false,
      diagnostics_enabled = true, -- enable diagnostics at start
      status_diagnostics_enabled = true, -- enable diagnostics in statusline
      icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
      ui_notifications_enabled = true, -- disable notifications when toggling UI elements
    },
  },
  -- Mappings can be configured through AstroCore as well.
  -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
  mappings = {
    -- first key is the mode
    n = {
      -- mappings seen under group name "Buffer"
      ["<Leader>bD"] = {
        function()
          require("astroui.status.heirline").buffer_picker(function(bufnr) require("astrocore.buffer").close(bufnr) end)
        end,
        desc = "Pick to close",
      },

      -- tables with just a `desc` key will be registered with which-key if it's installed
      -- this is useful for naming menus
      ["<Leader>b"] = { desc = "Buffers" },
      ["<Leader>r"] = { desc = "Overseer" },
      ["<Leader>x"] = { desc = "Misc" },
      ["<Leader>lp"] = { desc = "Peek" },
      -- quick save
      -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
      ["<leader>xu"] = { 'a<C-r>=trim(system("uuidgen"))<CR><ESC>', desc = "insert uuid" },
    },
    i = {
      ["<C-x><C-u>"] = { '<C-r>=trim(system("uuidgen"))<CR>', desc = "insert uuid" },
    },
    t = {},
    v = {},
    c = {},
  },
}

if vim.fn.executable "btop" then
  opts.mappings.n["<Leader>tt"] = {
    function() require("astrocore").toggle_term_cmd "btop" end,
    desc = "ToggleTerm Btop",
  }
end

if vim.fn.executable "lazydocker" == 1 then
  opts.mappings.n["<Leader>td"] = {
    function() require("astrocore").toggle_term_cmd "lazydocker" end,
    desc = "ToggleTerm lazydocker",
  }
end

if vim.g.neovide then
  opts.options.opt.guicursor = {
    "n-v-c:block-Cursor/lCursor-blinkwait300-blinkon750-blinkoff750",
    "i-ci:ver25-Cursor/lCursor-blinkwait300-blinkon750-blinkoff750",
    "r:hor50-Cursor/lCursor-blinkwait300-blinkon750-blinkoff750",
  }

  opts.options.g.neovide_hide_mouse_when_typing = true
  opts.options.g.neovide_cursor_animation_length = 0.1
  opts.options.g.neovide_cursor_trail_size = 0.5
  opts.options.g.neovide_cursor_smooth_blink = true
  opts.options.g.neovide_remember_window_position = true

  opts.mappings.n["<C-v>"] = { '"+p', desc = "Paste from clipboard", noremap = false, silent = true }
  opts.mappings.v["<C-v>"] = { "<C-R>+", desc = "Paste from clipboard", noremap = true, silent = true }
  opts.mappings.c["<C-v>"] = { "<C-R>+", desc = "Paste from clipboard", noremap = true, silent = true }
  opts.mappings.i["<C-v>"] = { "<C-R>+", desc = "Paste from clipboard", noremap = true, silent = true }
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  opts = opts,
}
