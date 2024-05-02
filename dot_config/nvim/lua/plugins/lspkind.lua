return {
  "onsails/lspkind.nvim",
  opts = function(_, opts)
    local get_icon = require("astroui").get_icon
    opts.mode = "symbol_text"
    opts.symbol_map = {
      Codeium = get_icon "Codeium",
      Text = get_icon "Key",
      Method = get_icon "Method",
      Function = get_icon "Method",
      Constructor = get_icon "Method",
      Field = get_icon "Field",
      Variable = get_icon "Variable",
      Class = get_icon "Class",
      Interface = get_icon "Interface",
      Module = get_icon "Namespace",
      Property = get_icon "Property",
      Unit = get_icon "Ruler",
      Value = get_icon "EnumMember",
      Enum = get_icon "Enum",
      Keyword = get_icon "Keyword",
      Snippet = get_icon "Snippet",
      Color = get_icon "Color",
      File = get_icon "File",
      Reference = get_icon "Structure",
      Folder = get_icon "FolderEmpty",
      EnumMember = get_icon "EnumMember",
      Constant = get_icon "Constant",
      Struct = get_icon "Structure",
      Event = get_icon "Event",
      Operator = get_icon "Operator",
      TypeParameter = get_icon "Parameter",
    }

    return opts
  end,
}
