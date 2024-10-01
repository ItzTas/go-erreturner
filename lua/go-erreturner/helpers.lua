local M = {}

--[[
    @param text string
]]
--
function M.write_in_file(text)
	local bufnr = vim.api.nvim_get_current_buf()
	local position = vim.api.nvim_win_get_cursor(0)

	local line = position[1] - 1

	print(line)

	vim.api.nvim_buf_set_lines(bufnr, line, line + 1, false, { text })
end

return M
