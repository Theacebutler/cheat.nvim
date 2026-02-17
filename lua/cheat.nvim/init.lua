local width = math.floor(vim.o.columns * 0.4)
local height = math.floor(vim.o.lines * 0.5)
local col = math.floor((vim.o.columns - width) / 2)
local row = math.floor((vim.o.lines - height) / 2)

local M = {}

M.open = function()
	local buff1 = vim.api.nvim_create_buf(false, false)
	local buff2 = vim.api.nvim_create_buf(false, false)
	vim.api.nvim_buf_set_lines(buff1, 0, -1, false, { "buff1" })
	vim.api.nvim_buf_set_lines(buff2, 0, -2, false, { "buff2" })
	M.win = vim.api.nvim_open_win(buff1, true, {
		split = "right",
		style = "minimal",
		width = width,
		height = height,
	})
	vim.api.nvim_win_set_buf(0, buff2)
	vim.cmd("split")
	vim.api.nvim_win_set_buf(0, buff1)
end
M.close = function()
	if M.win and vim.api.nvim_win_is_valid(0) then
		vim.api.nvim_win_hide(0)
	end
end

M.toggle = function()
	if M.win and vim.api.nvim_win_is_valid(0) then
		M.close()
	else
		M.open()
	end
end

vim.keymap.set("n", "<leader>ch", function()
	M.toggle()
end, {})
return M
