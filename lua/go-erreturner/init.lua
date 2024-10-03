local trees = require("go-erreturner.treesitter")

local M = {}

function M.return_err()
    local types = trees.get_current_function_signature()

    local bufnr = vim.api.nvim_get_current_buf()
    local current_line = vim.api.nvim_win_get_cursor(0)[1]

    local lines_to_write = {}
    for _, type in ipairs(types) do
        local type_text = type:type()
        table.insert(lines_to_write, type_text)
    end

    vim.api.nvim_buf_set_lines(bufnr, current_line - 1, current_line - 1, false, lines_to_write)
end

return M
