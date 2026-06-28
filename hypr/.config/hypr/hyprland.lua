hl.env("XCURSOR_SIZE", "24")

hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1,
})

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

hl.config({
	general = {
		gaps_in = 0,
		gaps_out = 0,
		border_size = 0,
		no_focus_fallback = 0,

		layout = "dwindle",
	},

	decoration = {
		rounding = 0,
		rounding_power = 4,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		dim_inactive = true,
		dim_strength = 0.15,
		border_part_of_window = false,

		blur = {
			enabled = false,
		},

		shadow = {
			enabled = false,
		},
	},

	animations = {
		enabled = false,
	},

	input = {
		kb_layout = "us,ara",
		kb_options = "ctrl:swapcaps,grp:alt_shift_toggle",
		repeat_rate = 50,
		repeat_delay = 200,

		follow_mouse = 1,

		touchpad = {
			disable_while_typing = true,
			natural_scroll = true,
		},
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		middle_click_paste = false,
	},

	ecosystem = {
		no_donation_nag = true,
	},

	misce = {},
})

hl.gesture({
	fingers = 2,
	direction = "pinchin",
	action = "cursorZoom",
	mode = "live",
	mods = "SUPER",
})

hl.gesture({
	fingers = 2,
	direction = "pinchout",
	action = "cursorZoom",
	mode = "live",
	mods = "SUPER",
})

local start_once = function()
	local exec_once = function(pname, run_cmd)
		local cmd = "pidof " .. pname .. " >/dev/null || " .. run_cmd
		hl.exec_cmd(cmd)
	end

	exec_once("hyprsunset", "hyprsunset")
	exec_once("hyprpaper", "hyprpaper")
	exec_once("qs", "qs -c noctalia-shell")
end

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	start_once()
end)

hl.on("config.reloaded", function()
	start_once()
end)

require("apps")
require("binds")
require("rules")
