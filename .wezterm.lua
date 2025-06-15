local wezterm = require("wezterm")

return {
	font_size = 14,
	color_scheme = "Catppuccin Mocha",

	use_fancy_tab_bar = false,
	--hide_tab_bar_if_only_one_tab = true,
	window_decorations = "RESIZE",
	show_new_tab_button_in_tab_bar = false,
	window_background_opacity = 0.9,
	--text_background_opacity = 0.9,

	adjust_window_size_when_changing_font_size = false,

	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 5,
	},

	-- Do not confirm when trying to close a tab
	keys = {
		{
			key = "w",
			mods = "CTRL|SHIFT",
			action = wezterm.action({
				CloseCurrentTab = { confirm = false },
			}),
		},
	},
}
