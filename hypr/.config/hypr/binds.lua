hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))

hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

hl.bind("SUPER + equal", hl.dsp.window.resize({ x = 50, y = 0 }))
hl.bind("SUPER + minus", hl.dsp.window.resize({ x = -50, y = 0 }))
hl.bind("SUPER + bracketright", hl.dsp.window.resize({ x = 0, y = 50 }))
hl.bind("SUPER + bracketleft", hl.dsp.window.resize({ x = 0, y = -50 }))

hl.bind("SUPER + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("SUPER + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + SHIFT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + SHIFT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + P", hl.dsp.window.pin({ action = "toggle" }))
hl.bind("SUPER + SPACE", hl.dsp.window.center({ action = "toggle" }))

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)

hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

for i = 1, 10 do
	local key = i % 10
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end
