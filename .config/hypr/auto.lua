local apps = {
	"hyprsunset",
	"hyprpaper",
	"swayosd-server",
}

local function start_apps()
	for _, app in ipairs(apps) do
		local cmd = "pidof " .. app .. " >/dev/null || " .. app
		hl.exec_cmd(cmd)
	end
end

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	start_apps()
end)

hl.on("config.reloaded", start_apps)
