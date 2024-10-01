local trees = require("go-erreturner.treesitter")

local M = {}

function M.setup() end

function M.return_err()
	local p = ""
	local types = trees.get_current_function_signature()
	for _, type in ipairs(types) do
		local t = vim.treesitter.get_node_text(type, 0)
		p = p .. " " .. t
	end
	print(p)
end

return M
