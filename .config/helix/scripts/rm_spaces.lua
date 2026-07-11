local input = io.read("*a")
local output = input:gsub("%s+", "")
io.write(output)
