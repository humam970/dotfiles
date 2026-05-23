local get_names = function(prefix)
	local names = {}
	for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
		local pattern = "func%s+(" .. prefix .. "[%w_]*)%s*%("
		local name = line:match(pattern)
		if name then
			table.insert(names, name)
		end
	end

	return names
end

local opts = { buffer = true }

vim.keymap.set("n", "ta", ":Compile go test -v ./...<CR>", opts)

-- runs TestXxx tests in the buffer
vim.keymap.set("n", "tbt", function()
	local names = get_names("Test")
	if #names == 0 then
		print("No Tests found.")
		return
	end

	local filter = string.format("'^(%s)$'", table.concat(names, "|"))
	local dir = "./" .. vim.fn.expand("%:h")
	local cmd = string.format("Compile go test -v -run %s %s", filter, dir)
	vim.cmd(cmd)
end, opts)

-- runs BenchmarkXxx tests in the buffer
vim.keymap.set("n", "tbb", function()
	local names = get_names("Benchmark")
	if #names == 0 then
		print("No Benchmarks tests found.")
		return
	end

	local filter = string.format("'^(%s)$'", table.concat(names, "|"))
	local dir = "./" .. vim.fn.expand("%:h")
	local cmd = string.format("Compile go test -v -run='^$' -bench %s %s", filter, dir)
	vim.cmd(cmd)
end, opts)

-- runs FuzzXxx tests in the buffer
vim.keymap.set("n", "tbf", function()
	local names = get_names("Fuzz")
	if #names == 0 then
		print("No Fuzz tests found.")
		return
	end

	local filter = string.format("'^(%s)$'", table.concat(names, "|"))
	local dir = "./" .. vim.fn.expand("%:h")
	local cmd = string.format("Compile go test -v -run '%s' %s", filter, dir)
	vim.cmd(cmd)
end, opts)

-- runs ExampleXxx tests in the buffer
vim.keymap.set("n", "tbe", function()
	local names = get_names("Example")
	if #names == 0 then
		print("No Examples tests found.")
		return
	end

	local filter = string.format("'^(%s)$'", table.concat(names, "|"))
	local dir = "./" .. vim.fn.expand("%:h")
	local cmd = string.format("Compile go test -v -run '%s' %s", filter, dir)
	vim.cmd(cmd)
end, opts)

-- runs the test function under the cursor
vim.keymap.set("n", "tf", function()
	local word = vim.fn.expand("<cword>")
	local dir = vim.fn.expand("%:h")

	local is_test = word:find("^Test")
	local is_bench = word:find("^Benchmark")
	local is_fuzz = word:find("^Fuzz")
	local is_example = word:find("^Example")

	if not (is_test or is_bench or is_fuzz or is_example) then
		vim.notify("Cursor is not on a Go testing function", vim.log.levels.ERROR)
		return
	end

	local cmd = "Compile go test -v"

	if is_bench then
		cmd = string.format("%s -run=^$ -bench=^%s$ ./%s", cmd, word, dir)
	else
		cmd = string.format("%s -run=^%s$ ./%s", cmd, word, dir)
	end

	vim.cmd(cmd)
end, opts)
