local trees = require("go-erreturner.treesitter")
local convert = require("go-erreturner.convert")
local settings = require("go-erreturner.settings")
local write = require("go-erreturner.write")

local M = {}

function M.setup(config)
    if not config then
        return
    end

    if config.error_variable_name then
        settings.error_variable = config.error_variable_name
    end
end

function M.return_err()
    local types = trees.get_current_function_signature()

    local zero_vals = convert.convert_signatures_to_zero_val(types)

    local payload = table.concat(zero_vals, ", ")

    write.write_if_err_return(payload)
end

return M

