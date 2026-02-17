-- $ curl cheat.sh/TOPIC       show cheat sheet on the TOPIC
-- $ curl cheat.sh/TOPIC/SUB   show cheat sheet on the SUB topic in TOPIC
-- $ curl cheat.sh/~KEYWORD    search cheat sheets for KEYWORD
local width = math.floor(vim.o.columns * 0.8)
local height = math.floor(vim.o.lines * 0.8)
local M = {
	width = width,
	height = height,
	col = math.floor((vim.o.columns - width) / 2),
	row = math.floor((vim.o.lines - height) / 2),
	quarter = 11,
}

return M
