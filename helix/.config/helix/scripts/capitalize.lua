for line in io.lines() do
	local capitalized = line:gsub("(%w)(%w*)", function(first, rest)
		return first:upper() .. rest:lower()
	end)
	print(capitalized)
end
