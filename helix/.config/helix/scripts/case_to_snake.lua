local input = io.read("*a")
local output = input:gsub("(%u)", "_%1"):lower()
output = output:gsub("^_", "")
io.write(output)
