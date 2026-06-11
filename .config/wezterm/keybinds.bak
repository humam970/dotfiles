local wezterm = require("wezterm")
local MOD = "ALT"

local M = {
	{
		key = "c",
		mods = MOD,
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "J",
		mods = MOD,
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "K",
		mods = MOD,
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "H",
		mods = MOD,
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "V",
		mods = MOD,
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
}
-- for i = 1, 8 do
-- 	table.insert(M, {
-- 		key = tostring(i),
-- 		mods = MOD,
-- 		action = wezterm.action.ActivateTab(i - 1),
-- 	})
-- end

return M
