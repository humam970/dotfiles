local terminal = "ghostty"
local launcher = "rofi -show drun"
local locker = "hyprlock"
local screen_shooter = "~/dotfiles/scripts/screenshot.fish"

local apps = {
	{
		key = "SUPER + Return",
		cmd = terminal,
	},
	{
		key = "SUPER + D",
		cmd = launcher,
	},
	{
		key = "SUPER + DELETE",
		cmd = locker,
	},
	{
		key = "Print",
		cmd = screen_shooter,
	},
	{
		key = "SUPER + PRINT",
		cmd = screen_shooter .. " full",
	},
}

for _, app in ipairs(apps) do
	hl.bind(app.key, hl.dsp.exec_cmd(app.cmd))
end
