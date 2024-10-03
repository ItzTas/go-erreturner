local M = {}

function M.get_current_function_signature()
    local node = vim.treesitter.get_node()
    while node do
        if node:type() ~= "method_declaration" and node:type() ~= "function_declaration" then
            node = node:parent()
        else
            local result_nodes = node:field("result")
            if not result_nodes then
                error("No result for current method")
            end

            local types = {}
            for _, result_node in ipairs(result_nodes) do
                if result_node:type() ~= "parameter_list" then
                    table.insert(types, result_node)
                    goto continue
                end

                local children = result_node:named_children()
                for _, child in ipairs(children) do
                    local type_nodes = child:field("type")
                    for _, type_node in ipairs(type_nodes) do
                        table.insert(types, type_node)
                    end
                end
                ::continue::
            end
            return types
        end
    end
end

return M
