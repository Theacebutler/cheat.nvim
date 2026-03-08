local M = {}
-- Get the search query
local function parse_query(q)
	if #q == 0 then
		return nil
	end
	-- the first word is the programming language or a search term, the rest is the search query
	local words = {}
	for word in q:gmatch("%w+") do
		table.insert(words, word)
	end
	local parm_1 = words[1]
	if #words == 1 then
		return parm_1
	end
	local search_query = table.concat(words, "+", 2)
	local sq = string.format("%s/%s", parm_1, search_query)
	return sq
end

local function call_api(q)
	-- call the API and return the path to the file where the response is stored
	local url = string.format("cheat.sh/%s", q)
	local path = string.gsub(q, "+", "_")
	path = string.gsub(path, "/", "_")
	path = string.format("/tmp/cheat_%s.txt", path)
	local cmd = string.format("curl google.com > %s", path)
	local output = vim.fn.system(cmd)
	if not output then
		print("Failed to execute curl")
		return nil
	end
	return path
end

local function create_buff(path)
	local buff = vim.fn.bufnr(path, true)
	if buff == -1 then
		buff = vim.api.nvim_create_buf(false, true)
	end
	vim.bo[buff].buftype = "nofile"
	vim.bo[buff].bufhidden = "hide"
	vim.bo[buff].swapfile = false
	vim.bo[buff].buflisted = false
	vim.bo[buff].modifiable = false
	vim.bo[buff].filetype = "markdown"
	vim.api.nvim_buf_set_keymap(buff, "n", "q", ":q<CR>", { noremap = true, silent = true })
	return buff
end

local function main()
	local q = vim.fn.input("Enter programming language fallowd by the search query: ")
	local full_query = parse_query(q)
	if full_query == nil then
		vim.notify("No query provided", vim.log.levels.ERROR)
		return
	end
	local res_file = call_api(full_query)
	if not res_file then
		return
	end

	local buff = create_buff(res_file)
	M.win = vim.api.nvim_open_win(buff, true, {
		split = "below",
		width = 50,
		height = 30,
		focusable = true,
	})
end
main()

M.setup = function(opts)
	vim.api.nvim_create_user_command("Cheat", main, {})
	local open = opts.open or "<leader>sc"
	vim.keymap.set("n", open, ":Cheat<CR>", { noremap = true, silent = true })
end

return M
