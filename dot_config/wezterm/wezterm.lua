local wezterm = require("wezterm")
local action = wezterm.action

local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local function is_vim(pane)
	local process_name = basename(pane:get_foreground_process_name())
	return process_name == "vim" or process_name == "nvim" or string.find(process_name, "python")
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

local function bind_keys(key, mods, event)
	return { key = key, mods = mods, action = event }
end

local function unbind_keys(key, mod)
	return bind_keys(key, mod, action.SendKey({ key = key, mods = mod }))
end

return {
	-- color_scheme = "Everblush",
	color_scheme = "Catppuccin Macchiato",
	enable_wayland = false,
	default_prog = { "/bin/bash" },

	font = wezterm.font_with_fallback({
		-- { family = "JetBrains Mono", harfbuzz_features = { "zero=1", "cv06=1", "calt=0" } },
		{ family = "Intel One Mono" },
		{ family = "JetBrains Mono Freeze" },
		{ family = "Symbols Nerd Font" },
		{ family = "Noto Color Emoji" },
	}),

	font_size = 12,
	-- line_height = 1.2,

	-- dpi = 90,

	window_padding = { left = "1cell", right = "1cell", top = 0, bottom = 0 },

	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,

	window_decorations = "NONE",
	initial_rows = 35,
	initial_cols = 130,

	use_cap_height_to_scale_fallback_fonts = true,
	audible_bell = "Disabled",

	-- disable window close confirmation
	window_close_confirmation = "NeverPrompt",

	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },

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

		bind_keys("w", "LEADER", action.CloseCurrentPane({ confirm = true })),
		bind_keys("w", "LEADER|SHIFT", action.CloseCurrentTab({ confirm = true })),
		bind_keys("z", "LEADER", action.TogglePaneZoomState),
		bind_keys('"', "LEADER|SHIFT", action.SplitVertical({ domain = "CurrentPaneDomain" })),
		bind_keys("%", "LEADER|SHIFT", action.SplitHorizontal({ domain = "CurrentPaneDomain" })),
		bind_keys("T", "LEADER|SHIFT", action.SpawnTab("CurrentPaneDomain")),

		unbind_keys("z", "CTRL|SHIFT"),
		unbind_keys('"', "CTRL|SHIFT|ALT"),
		unbind_keys("%", "CTRL|SHIFT|ALT"),
		unbind_keys("t", "CTRL|SHIFT"),
		unbind_keys("w", "CTRL|SHIFT"),
	},
}
