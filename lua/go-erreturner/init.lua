local trees = require("go-erreturner.treesitter")
local convert = require("go-erreturner.convert")
local settings = require("go-erreturner.settings")
local write = require("go-erreturner.write")

local M = {}

local function get_payload()
    local types = trees.get_current_function_signature()

    local zero_vals = convert.convert_signatures_to_zero_val(types)

    if not zero_vals then
        return ""
    end

    return table.concat(zero_vals, ", ")
end

function M.setup(config)
    if not config then
        return
    end

    if config.error_variable_name then
        settings.error_variable = config.error_variable_name
    end
end

function M.return_err()
    write.write_if_err_return(get_payload())
end

function M.println_err()
    write.write_if_err_println_and_error_and_return(get_payload())
end

return M

