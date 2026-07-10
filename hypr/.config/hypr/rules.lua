hl.window_rule({
	enabled = true,
	match = {
		class = "com.gabm.satty",
	},
	float = true,
	center = true,
	size = { 1920 * 0.95, 1080 * 0.95 },
	border_size = 2,
})

hl.window_rule({
	enabled = true,
	match = {
		class = "discord",
	},
	workspace = 10,
})
