local settings = require("go-erreturner.settings")

local M = {}

local zero_values = {
    string = '""',
    rune = "'\\x00'",
    int = 0,
    int8 = 0,
    int16 = 0,
    int32 = 0,
    int64 = 0,
    uint = 0,
    uint8 = 0,
    uint16 = 0,
    uint32 = 0,
    uint64 = 0,
    float32 = 0.0,
    float64 = 0.0,
    complex64 = "0 + 0i",
    complex128 = "0 + 0i",
    bool = "false",
    chan = "nil",
    func = "nil",
    any = "nil",
    struct = "{}",
    ["*string"] = "nil",
    ["*rune"] = "nil",
    ["*int"] = "0",
    ["*int8"] = "0",
    ["*int16"] = "0",
    ["*int32"] = "0",
    ["*int64"] = "0",
    ["*uint"] = "0",
    ["*uint8"] = "0",
    ["*uint16"] = "0",
    ["*uint32"] = "0",
    ["*uint64"] = "0",
    ["*float32"] = "0.0",
    ["*float64"] = "0.0",
    ["*complex64"] = "0 + 0i",
    ["*complex128"] = "0 + 0i",
    ["*bool"] = "false",
    ["*struct"] = "{}",
    ["*interface{}"] = "nil",
    ["interface{}"] = "nil",
}

local function convert_signature_to_zero_val(sig_text, sig_type)
    local zero_val = zero_values[sig_text]
    if zero_val then
        return zero_val
    end

    if sig_type == "slice_type" or sig_type == "array_type" then
        return sig_text .. "{}"
    end

    local zero_struct = sig_text .. "{}"
    if sig_type == "pointer_type" and zero_struct ~= "nil" then
        return "&" .. zero_struct
    end
    return zero_struct
end

function M.convert_signatures_to_zero_val(signatures) -- @param signatures table<Node>
    local zero_vals = {}

    if not signatures then
        return {}
    end

    for _, signature in ipairs(signatures) do
        local text = vim.treesitter.get_node_text(signature, 0)
        if text == "error" then
            table.insert(zero_vals, settings.error_variable)
            goto continue
        end
        local type = signature:type()
        if type == "pointer_type" then
            text = string.gsub(text, "^%*", "")
        end
        local zero_val = convert_signature_to_zero_val(text, type)
        table.insert(zero_vals, zero_val)
        ::continue::
    end
    return zero_vals
end

return M
