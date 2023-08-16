local get_hlgroup = require("astronvim.utils").get_hlgroup

local buffer_bar_color = get_hlgroup("BufferBarActive", { fg = "#242e32", bg = "#242e32" })

return {
  buffer_active_bg = buffer_bar_color.bg,
  buffer_path_fg = "#6E738D",
}
