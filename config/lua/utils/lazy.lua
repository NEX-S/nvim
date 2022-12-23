local M = {}

M.require_on_index = function (require_path)
    return setmetatable ({}, {
        __index = function (_, key)
            return require(require_path)[key]
        end,

        __newindex = function (_, key, value)
            require(require_path)[key] = value
        end,
    })
end

M.require_on_module_call = function (require_path)
    return setmetatable ({}, {
        __call = function (_, ...)
            return require(require_path)(...)
        end,
    })
end

M.require_on_exported_call = function (require_path)
    return setmetatable ({}, {
        __index = function (_, k)
            return function (...)
                return require(require_path)[k](...)
            end
        end,
    })
end

return lazy
