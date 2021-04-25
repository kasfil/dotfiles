local highlink = require("configs.utils").highlink

vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1

vim.cmd("colorscheme nord")

-- barbar-nvim
vim.api.nvim_exec([[
    hi! BufferCurrentMod guifg=#ebcb8b guibg=#2e3440
    hi! BufferVisibleMod guifg=#ebcb8b guibg=#4c566a
    hi! BufferInactiveMod guifg=#ebcb8b guibg=#4c566a
]], false)

-- Custom Treesitter syntax highlighting
highlink("TSAnnotation", "Structure")
highlink("TSAttribute", "asciidocAttributeEntry")
highlink("TSBoolean", "Boolean")
highlink("TSCharacter", "Character")
highlink("TSComment", "Comment")
highlink("TSConstructor", "cIncluded")
highlink("TSConditional", "Conditional")
highlink("TSConstant", "Constant")
highlink("TSConstBuiltin", "Define")
highlink("TSConstMacro", "Define")
highlink("TSError", "Error")
highlink("TSException", "Exception")
highlink("TSField", "Identifier")
highlink("TSFloat", "Float")
highlink("TSFunction", "Function")
highlink("TSFuncBuiltin", "Function")
highlink("TSFuncMacro", "Function")
highlink("TSInclude", "Include")
highlink("TSKeyword", "Keyword")
highlink("TSKeywordFunction", "Function")
highlink("TSLabel", "Label")
highlink("TSMethod", "Function")
highlink("TSNamespace", "xmlNamespace")
-- highlink("TSNone", "") -- TODO
highlink("TSNumber", "Number")
highlink("TSOperator", "Operator")
highlink("TSParameter", "Operator")
highlink("TSParameterReference", "Operator")
highlink("TSProperty", "TSField")
highlink("TSPunctDelimiter", "Keyword")
highlink("TSPunctBracket", "Keyword")
highlink("TSPunctSpecial", "Keyword")
highlink("TSRepeat", "Repeat")
highlink("TSString", "String")
highlink("TSStringRegex", "SpecialChar")
highlink("TSStringEscape", "SpecialChar")
highlink("TSSymbol", "rubySymbol")
highlink("TSTag", "Tag")
highlink("TSTagDelimiter", "Keyword")
highlink("TSText", "String")
highlink("TSStrong", "Bold")
highlink("TSEmphasis", "Italic")
highlink("TSUnderline", "Underline")
highlink("TSStrike", "Underline")
highlink("TSTitle", "Title")
highlink("TSLiteral", "Tag")
highlink("TSURI", "markdownLinkText")
highlink("TSNote", "markdownFootnote")
highlink("TSWarning", "healthWarning")
highlink("TSDanger", "healthError")
highlink("TSType", "Type")
highlink("TSTypeBuiltin", "Type")
highlink("TSVariable", "Identifier")
highlink("TSVariableBuiltin", "Identifier")
