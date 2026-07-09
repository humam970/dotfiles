local terminal = "ghostty"
local launcher = "rofi -show drun"
-- local control_center = "qs -c noctalia-shell ipc call controlCenter toggle"
-- local settings = "qs -c noctalia-shell ipc call settings toggle"
local locker = "hyprlock"

hl.bind("SUPER + Return", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + D", hl.dsp.exec_cmd(launcher))
hl.bind("SUPER + Delete", hl.dsp.exec_cmd(locker))
hl.bind("Print", hl.dsp.exec_raw("~/dotfiles/scripts/screenshot.fish"))
hl.bind("SUPER + Print", hl.dsp.exec_raw("~/dotfiles/scripts/screenshot.fish full"))
