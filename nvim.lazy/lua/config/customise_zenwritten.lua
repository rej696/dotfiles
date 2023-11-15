local lush = require "lush"
local base = require "zenwritten"

local specs = lush.parse(function()
    return {
        Function { base.Function, gui = "italic" },
    }
end)

lush.apply(lush.compile(specs))
