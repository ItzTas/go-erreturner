local M = {}

local zero_values = {
    string = '""',
    rune = "'\\0'",
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
    bool = false,
    pointer = "nil",
    slice = "nil",
    map = "nil",
    chan = "nil",
    func = "nil",
    interface = "nil",
    array = "{}",
    struct = "{}",
}

function M.convert_signature_to_zero_val(signatures) end

return M
