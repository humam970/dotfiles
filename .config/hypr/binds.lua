local dsp = hl.dsp
local focus = hl.dsp.focus
local window = hl.dsp.window

local binds = {
	{
		key = "SUPER + H",
		fn = focus,
		args = { direction = "left" },
	},
	{
		key = "SUPER + L",
		fn = focus,
		args = { direction = "right" },
	},
	{
		key = "SUPER + K",
		fn = focus,
		args = { direction = "up" },
	},
	{
		key = "SUPER + J",
		fn = focus,
		args = { direction = "down" },
	},

	{
		key = "SUPER + SHIFT + H",
		fn = window.move,
		args = { direction = "left" },
	},
	{
		key = "SUPER + SHIFT + L",
		fn = window.move,
		args = { direction = "right" },
	},
	{
		key = "SUPER + SHIFT + K",
		fn = window.move,
		args = { direction = "up" },
	},
	{
		key = "SUPER + SHIFT + J",
		fn = window.move,
		args = { direction = "down" },
	},

	{
		key = "SUPER + EQUAL",
		fn = window.resize,
		args = { x = 50, y = 0 },
	},
	{
		key = "SUPER + MINUS",
		fn = window.resize,
		args = { x = -50, y = 0 },
	},
	{
		key = "SUPER + bracketright",
		fn = window.resize,
		args = { x = 0, y = 50 },
	},
	{
		key = "SUPER + bracketleft",
		fn = window.resize,
		args = { x = 0, y = -50 },
	},

	{
		key = "SUPER + F",
		fn = window.fullscreen,
		args = { action = "toggle" },
	},
	{
		key = "SUPER + T",
		fn = window.float,
		args = { action = "toggle" },
	},
	{
		key = "SUPER + Q",
		fn = window.close,
	},
	{
		key = "SUPER + mouse:272",
		fn = window.drag,
		args = { mouse = true },
	},
	{
		key = "SUPER + P",
		fn = window.pin,
		args = { action = "toggle" },
	},
	{
		key = "SUPER + SPACE",
		fn = window.center,
		args = { action = "toggle" },
	},
	{
		key = "SUPER + M",
		fn = dsp.exec_cmd,
		args = "ashell msg toggle-visibility",
	},

	{
		key = "XF86MonBrightnessUp",
		fn = dsp.exec_cmd,
		args = "brightnessctl set 5%+",
		flags = { locked = true, repeating = true },
	},
	{
		key = "XF86MonBrightnessDown",
		fn = dsp.exec_cmd,
		args = "brightnessctl set 5%-",
		flags = { locked = true, repeating = true },
	},
	{
		key = "XF86AudioRaiseVolume",
		fn = dsp.exec_cmd,
		args = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+",
		flags = { locked = true, repeating = true },
	},
	{
		key = "XF86AudioLowerVolume",
		fn = dsp.exec_cmd,
		args = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",
		flags = { locked = true, repeating = true },
	},
	{
		key = "XF86AudioMicMute",
		fn = dsp.exec_cmd,
		args = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle",
		flags = { repeating = true },
	},
	{
		key = "XF86AudioMute",
		fn = dsp.exec_cmd,
		args = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
		flags = { repeating = true },
	},
}

for _, bind in ipairs(binds) do
	hl.bind(bind.key, bind.fn(bind.args), bind.flags)
end

for i = 1, 10 do
	local key = i % 10
	hl.bind("SUPER + " .. key, focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, window.move({ workspace = i, follow = false }))
end
