hl.window_rule({
	enabled = true,
	match = {
		class = "com.gabm.satty",
	},
	float = true,
	center = true,
	size = { 1920 * 0.85, 1080 * 0.85 },
	border_size = 2,
})

hl.window_rule({
	enabled = true,
	match = {
		class = "discord",
	},
	workspace = 10,
})

hl.window_rule({
	enabled = true,
	match = {
		class = "com.mitchellh.ghostty",
	},
})
