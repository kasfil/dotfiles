return {
  "stevearc/aerial.nvim",
  opts = function(_, opts)
    local get_icon = require("astroui").get_icon

    opts.layout.win_opts = { winhl = "Normal:SideWin,NormalNC:SideWin" }
    opts.manage_folds = false
    opts.link_folds_to_tree = false
    opts.link_tree_to_folds = false
    opts.ignore = {
      unlisted_buffers = true,
      filetypes = {},
      buftypes = "special",
      wintypes = "special",
    }

    opts.icons = {
      Array = get_icon "Array",
      Boolean = get_icon "Boolean",
      Class = get_icon "Class",
      Color = get_icon "Color",
      Constant = get_icon "Constant",
      Constructor = get_icon "Method",
      Enum = get_icon "Enum",
      EnumMember = get_icon "EnumMember",
      Event = get_icon "Event",
      Field = get_icon "Field",
      File = get_icon "File",
      Function = get_icon "Method",
      Interface = get_icon "Interface",
      Key = get_icon "Key",
      Method = get_icon "Method",
      Module = get_icon "Namespace",
      Namespace = get_icon "Namespace",
      Null = get_icon "Variable",
      Member = get_icon "EnumMember",
      Object = get_icon "Class",
      Operator = get_icon "Operator",
      Package = get_icon "Package",
      Property = get_icon "Property",
      String = get_icon "String",
      Struct = get_icon "Structure",
      TypeParameter = get_icon "Parameter",
      Variable = get_icon "Variable",
    }

    return opts
  end,
}
