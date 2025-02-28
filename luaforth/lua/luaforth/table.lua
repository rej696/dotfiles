local M = Forth
local utils = require('luaforth.utils')

local table_metatable = {
    __tostring = utils.stringify,
    __concat = function(a, b)
        if type(a) == "table" and type(b) == "table" then
            for i=1,#b do
                table.insert(a, b[i])
            end
            return a
        elseif type(a) == "table" and type(b) ~= "table" then
            table.insert(a, b)
            return a
        elseif type(a) ~= "table" and type(b) == "table" then
            table.insert(b, a)
            return b
        else
            error("Unable to add types " .. type(a) .. " and " .. type(b))
            return a, b
        end
    end,
    __add = function(a, b)
        if type(a) == "table" and type(b) ~= "table" then
            for i, v in ipairs(a) do
                a[i] = v + b
            end
            return a
        elseif type(a) ~= "table" and type(b) == "table" then
            for i, v in ipairs(b) do
                b[i] = a + v
            end
            return b
        else
            error("Unable to add types " .. type(a) .. " and " .. type(b))
            return a, b
        end
    end,
    __sub = function(a, b)
        if type(a) == "table" and type(b) ~= "table" then
            for i, v in ipairs(a) do
                a[i] = v - b
            end
            return a
        elseif type(a) ~= "table" and type(b) == "table" then
            for i, v in ipairs(b) do
                b[i] = a - v
            end
            return b
        else
            error("Unable to add types " .. type(a) .. " and " .. type(b))
            return a, b
        end
    end,
    __div = function(a, b)
        if type(a) == "table" and type(b) ~= "table" then
            for i, v in ipairs(a) do
                a[i] = v / b
            end
            return a
        elseif type(a) ~= "table" and type(b) == "table" then
            for i, v in ipairs(b) do
                b[i] = a / v
            end
            return b
        else
            error("Unable to add types " .. type(a) .. " and " .. type(b))
            return a, b
        end
    end,
    __mul = function(a, b)
        if type(a) == "table" and type(b) ~= "table" then
            for i, v in ipairs(a) do
                a[i] = v * b
            end
            return a
        elseif type(a) ~= "table" and type(b) == "table" then
            for i, v in ipairs(b) do
                b[i] = a * v
            end
            return b
        else
            error("Unable to add types " .. type(a) .. " and " .. type(b))
            return a, b
        end
    end,
    -- __concat = function(a, b)
    --     return tostring(a) .. tostring(b)
    -- end
}

M.TS = { n = 0 }

M.interpret_table_entry = function()
    if M.word then
        if tonumber(M.word) then
            table.insert(M.peek(M.TS), tonumber(M.word))
        else
            table.insert(M.peek(M.TS), M.word)
        end
        return true
    end
end

M.modes.table = function()
    M.word = M:get_word_or_newline() or ""
    if M.debug then
        M.d.p_s_c()
    end
    local _ = M.interpret_primitive()
        or M.interpret_nonprimitive()
        or M.interpret_table_entry()
        or error("can't build table: " .. tostring(M.word))
end

M._F["{"] = function()
    M.mode = "table"
    local t = {}
    setmetatable(t, table_metatable)
    M.push(M.TS, t)
    -- M.TS.n = M.TS.n + 1
    -- M.TS[M.TS.n] = {}
end

M._F["}"] = function()
    local t = M.pop(M.TS)
    if t then
        if M.TS.n == 0 then
            M.push(M.DS, t)
            M.mode = "interpret"
        else
            M.push(M.TS, t)
        end
    else
        error("No table to end")
    end
end

-- parse lua table
M._F["{L"] = function()
    local str = M:parse_to_symbol("L}")
    if str then
        local t = utils.eval("return { " .. str .. " }")
        if t then
            setmetatable(t, table_metatable)
            M.push(M.DS, t)
        else
            error("Unable to load table from string: " .. str)
        end
    else
        error("Unable to parse table literal")
    end
end
