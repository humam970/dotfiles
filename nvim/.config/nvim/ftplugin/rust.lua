require("mini.pairs").map_buf(0, "i", "'", { action = "close", pair = "''" })
vim.keymap.set("i", "'", "'", { buffer = true })

-- test all
vim.keymap.set("n", "ta", ":Compile cargo test<CR>", { buffer = true })

-- test buffer: doesn't work because cargo doesn't care about file paths... it wants module paths
-- vim.keymap.set("n", "tb", function()
-- 	local file = vim.fn.expand("%")
-- 	vim.cmd("Compile cargo test ./" .. file)
-- end, { buffer = true })

-- test function: dumb test... this will run every function that has the "word" in its name
vim.keymap.set("n", "tf", function()
	local word = vim.fn.expand("<cword>")
	vim.cmd("Compile cargo test " .. word, { buffer = true })
end)
