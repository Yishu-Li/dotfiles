local home = os.getenv("HOME")

----------------
---- MONITORS ----
----------------

hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60.01",
	position = "0x0",
	scale = 1.0,
})

hl.monitor({
	output = "DP-1",
	mode = "1920x1080@60.0",
	position = "1920x0",
	scale = 1.5,
	mirror = "eDP-1",
})

--------------------
---- USER CONFIG ----
--------------------

hl.config({
	general = {
		layout = "scrolling",
	},

	scrolling = {
		direction = "right",
	},

	decoration = {
		active_opacity = 1.0,
		inactive_opacity = 0.9,
		fullscreen_opacity = 1.0,
		dim_inactive = true,
		dim_strength = 0.1,
	},

	input = {
		mouse_refocus = false,
	},

	misc = {
		vrr = 1,
	},
})

---------------------
---- ENVIRONMENT -----
---------------------

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("QS_ICON_THEME", "Tela-light")
hl.env("EDITOR", "nvim")

-----------------
---- AUTOSTART ----
-----------------

hl.on("hyprland.start", function()
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd(home .. "/.config/hypr/scripts/RainbowBorders.sh")
end)

----------------------
---- WINDOW RULES -----
----------------------

-- Additional applications for Caelestia's special workspaces.
hl.window_rule({ match = { class = "F5 VPN|com.follow.clash" }, workspace = "special:special" })
hl.window_rule({ match = { class = "splayer" }, workspace = "special:music" })
hl.window_rule({ match = { class = "wechat|Slack|slack" }, workspace = "special:communication" })
hl.window_rule({ match = { class = "Kuro" }, workspace = "special:todo" })
hl.window_rule({ match = { class = "flclash|clash" }, workspace = "special:specialws" })

-- Zotero dialogs.
hl.window_rule({
	match = { title = "Zotero Settings|Plugins Manager" },
	float = true,
})

-- Remove decoration from WeChat windows except Moments (朋友圈).
hl.window_rule({
	match = {
		class = "^(wechat)$",
		title = "negative:^朋友圈$",
	},
	no_blur = true,
	no_shadow = true,
	border_size = 0,
})

---------------------
---- LAYER RULES -----
---------------------

hl.layer_rule({
	match = { namespace = "caelestia-drawers" },
	blur = true,
	ignore_alpha = 0.57,
})

------------------
---- KEYBINDS -----
------------------

-- Move the active window to the adjacent workspace.
hl.bind("SUPER + SHIFT + bracketright", hl.dsp.window.move({ workspace = "+1" }), { repeating = true })
hl.bind("SUPER + SHIFT + bracketleft", hl.dsp.window.move({ workspace = "-1" }), { repeating = true })

-- Switch between scrolling and dwindle layouts.
hl.bind(
	"SUPER + ALT + T",
	hl.dsp.exec_cmd(
		[[if [ "$(hyprctl getoption general:layout -j | jq -r .str)" = "dwindle" ]; then ]]
			.. [[hyprctl keyword general:layout scrolling && notify-send -u low -t 2000 "Hyprland" "Layout: Scrolling"; ]]
			.. [[else hyprctl keyword general:layout dwindle && notify-send -u low -t 2000 "Hyprland" "Layout: Dwindle"; fi]]
	)
)

-- Scrolling-layout column controls.
hl.bind("SUPER + ALT + Comma", hl.dsp.layout("move -col"))
hl.bind("SUPER + ALT + Period", hl.dsp.layout("move +col"))
hl.bind("SUPER + O", hl.dsp.layout("promote"))
hl.bind("SUPER + SHIFT + H", hl.dsp.layout("swapcol l"))
hl.bind("SUPER + SHIFT + L", hl.dsp.layout("swapcol r"))

-- Replace the new defaults for these keys with the old scrolling colresize actions.
hl.unbind("SUPER + Minus")
hl.unbind("SUPER + Equal")
hl.bind("SUPER + Minus", hl.dsp.layout("colresize -0.05"), { repeating = true })
hl.bind("SUPER + Equal", hl.dsp.layout("colresize +0.05"), { repeating = true })

-- Vim-style focus and window movement.
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + I", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + O", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Special workspace and utility shortcuts.
hl.bind("SUPER + SHIFT + D", hl.dsp.window.move({ workspace = "special:communication" }))
hl.bind("CTRL + ALT + Escape", hl.dsp.exec_cmd("qps"))
