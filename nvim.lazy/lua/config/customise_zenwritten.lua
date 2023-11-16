local lush = require "lush"
local base = require "zenwritten"
local p = require "zenwritten.palette"

local specs = lush.parse(function()
    return {
        Function { base.Function, gui = "italic", fg = p.dark.leaf},
        Constant { base.Constant, gui = "italic", fg = p.dark.wood},
        Preproc { base.Preproc, fg = p.dark.fg },
        Statement { base.Statement, fg = p.dark.rose},
        Number { base.Number, fg = p.dark.blossom},
        Type { base.Type, fg = p.dark.sky},
    }
end)

lush.apply(lush.compile(specs))
