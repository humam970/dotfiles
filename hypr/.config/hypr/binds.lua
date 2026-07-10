local dsp = hl.dsp
local bind = hl.bind
local focus = dsp.focus
local window = dsp.window


bind("SUPER + H", focus({ direction = "left" }))
bind("SUPER + L", focus({ direction = "right" }))
bind("SUPER + K", focus({ direction = "up" }))
bind("SUPER + J", focus({ direction = "down" }))

bind("SUPER + SHIFT + H", window.move({ direction = "left" }))
bind("SUPER + SHIFT + L", window.move({ direction = "right" }))
bind("SUPER + SHIFT + K", window.move({ direction = "up" }))
bind("SUPER + SHIFT + J", window.move({ direction = "down" }))

bind("SUPER + EQUAL", window.resize({ x = 50, y = 0 }))
bind("SUPER + MINUS", window.resize({ x = -50, y = 0 }))
bind("SUPER + bracketright", window.resize({ x = 0, y = 50 }))
bind("SUPER + bracketleft", window.resize({ x = 0, y = -50 }))

bind("SUPER + F", window.fullscreen({ action = "toggle" }))
bind("SUPER + T", window.float({ action = "toggle" }))
bind("SUPER + Q", window.close())
bind("SUPER + mouse:272", window.drag(), { mouse = true })
bind("SUPER + P", window.pin({ action = "toggle" }))
bind("SUPER + SPACE", window.center({ action = "toggle" }))

bind("XF86MonBrightnessUp", dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
bind("XF86MonBrightnessDown", dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
bind(
	"XF86AudioRaiseVolume",
	dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
bind(
	"XF86AudioLowerVolume",
	dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)

bind("XF86AudioMicMute", dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
bind("XF86AudioMute", dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

bind("SUPER + M", dsp.exec_cmd("ashell msg toggle-visibility"))

for i = 1, 10 do
	local key = i % 10
	bind("SUPER + " .. key, focus({ workspace = i }))
	bind("SUPER + SHIFT + " .. key, window.move({ workspace = i, follow = false }))
end
