local M = {}

--- Require on index.
function M.require_on_index ()
    return setmetatable ({}, {
        __index = function (_, key)
            return require(require_path)[key]
        end,

        __newindex = function (_, key, value)
            require(require_path)[key] = value
        end,
    })
end

--- Requires only when you call the _module_ itself.
function M.require_on_module_call (require_path)
    return setmetatable ({}, {
        __call = function (_, ...)
            return require(require_path)(...)
        end,
    })
end

--- Require when an exported method is called.
function M.require_on_exported_call (require_path)
    return setmetatable ({}, {
        __index = function (_, k)
            return function(...)
                return require(require_path)[k](...)
            end
        end,
    })
end

return M
