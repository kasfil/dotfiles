local wezterm = require("wezterm")

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function is_vim(pane)
	local process_name = basename(pane:get_foreground_process_name())
	return process_name == "vim" or process_name == "nvim"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",

	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	local direction = resize_or_move == "resize" and key or direction_keys[key]
	key = resize_or_move == "resize" and key .. "Arrow" or key
	local mods = "CTRL"
	return {
		key = key,
		mods = mods,
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				-- for nvim resize key i map it with alt arrow key
				win:perform_action({
					SendKey = {
						key = key,
						mods = mods,
					},
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction, 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction }, pane)
				end
			end
		end),
	}
end

return {
	-- color_scheme = "Everblush",
	color_scheme = "Catppuccin Macchiato",
	enable_wayland = false,
	default_prog = { "/bin/bash" },

	font = wezterm.font_with_fallback({
		{ family = "JetBrains Mono Freeze" },
		{ family = "Symbols Nerd Font" },
		{ family = "JetBrainsMono Nerd Font" },
	}),

	font_size = 10,
	line_height = 1.1,

	window_padding = { left = "1cell", right = "1cell", top = "3px", bottom = "3px" },

	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = false,
	tab_bar_at_bottom = true,

	window_decorations = "NONE",
	initial_rows = 32,
	initial_cols = 150,

	use_cap_height_to_scale_fallback_fonts = true,
	audible_bell = "Disabled",

	-- disable window close confirmation
	window_close_confirmation = "NeverPrompt",

	keys = {
		-- move between split panes
		split_nav("move", "h"),
		split_nav("move", "j"),
		split_nav("move", "k"),
		split_nav("move", "l"),

		-- resize panes
		split_nav("resize", "Left"),
		split_nav("resize", "Down"),
		split_nav("resize", "Up"),
		split_nav("resize", "Right"),
	},
}
