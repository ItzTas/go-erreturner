local settings = require("go-erreturner.settings")

local M = {}

local function write_if_err(table_payload)
    local line_number = vim.api.nvim_win_get_cursor(0)[1] + 1
    print(settings.error_variable)
    local first = string.format("if %s != nil {", settings.error_variable)
    vim.api.nvim_buf_set_lines(0, line_number - 1, line_number - 1, false, { first })

    for _, line in ipairs(table_payload) do
        line_number = line_number + 1
        vim.api.nvim_buf_set_lines(0, line_number - 1, line_number - 1, false, { line })
    end

    line_number = line_number + 1
    vim.api.nvim_buf_set_lines(0, line_number - 1, line_number - 1, false, { "}" })
end

function M.write_if_err_return(return_val) -- @param return_val string
    write_if_err({ string.format("return %s", return_val) })
    vim.cmd("normal! V")
    vim.cmd("normal! 3j")
    vim.cmd("silent normal! =")
end

function M.write_if_err_println_and_error_and_return() end

return M

