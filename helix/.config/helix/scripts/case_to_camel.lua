local input = io.read("*a")
local output = input:gsub("_%a", function(s)
    return s:sub(2,2):upper()  -- capitalize the letter after underscore
end)
io.write(output)
