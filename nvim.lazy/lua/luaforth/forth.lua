local M = {}

-- http://angg.twu.net/miniforth/miniforth6.lua

-- General utility functions
local function split(str, pat)
    local t = {}
    local f = function(word) table.insert(t, word) end
    local _ = string.gsub(str, pat or "([^%s]+)", f)
    return t
end

local function eval(str)
    return assert(loadstring(str))()
end

local function printf(...) M.write(string.format(...)) end

local function partial(f, arg)
    return function(...)
        return f(arg, ...)
    end
end

local function map(f, t)
    local ret = {}
    for k, v in pairs(t) do
        ret[k] = f(v)
    end
    return ret
end

local function ipairs_map(f, t)
    local g = function(a, i)
        i = i + 1
        local v = a[i]
        if v then
            return i, f(v)
        end
    end
    return g, t, 0
end

local function pairs_map(f, t)
    local g = function(a, b)
        local k, v = next(a, b)
        if k then
            return k, f(v)
        end
    end
    return g, t, nil
end

local mapconcat = function(f, A, sep)
    return table.concat(map(f, A), sep)
end

local sorted = function(tbl, lt)
    table.sort(tbl, lt); return tbl
end

local keys = function(tbl)
    local ks = {}
    for k, _ in pairs(tbl) do table.insert(ks, k) end
    return ks
end

-- pretty print functions
local tos_compare_pairs = function(pair1, pair2)
    local key1, key2   = pair1.key, pair2.key
    local type1, type2 = type(key1), type(key2)
    if type1 == type2 then
        if type1 == "number" then return key1 < key2 end
        if type1 == "string" then return key1 < key2 end
        return tostring(key1) < tostring(key2) -- fast
    else
        return type1 < type2                 -- numbers before strings before tables, etc
    end
end

local tos_sorted_pairs = function(T)
    local Tpairs = {}
    for key, val in pairs(T) do
        table.insert(Tpairs, { key = key, val = val })
    end
    table.sort(Tpairs, tos_compare_pairs)
    return Tpairs
end

local tos_pair = function(pair)
    return tos(pair.key) .. "=" .. tos(pair.val)
end

local tos_table = function(T, sep)
    return "{" .. mapconcat(tos_pair, tos_sorted_pairs(T), sep or ", ") .. "}"
end

tos = function(o)
    local t = type(o)
    if t == "number" then return tostring(o) end
    if t == "string" then return string.format("%q", o) end
    if t == "table" then return tos_table(o) end
    return "<" .. tostring(o) .. ">"
end

local prettyprint = function(...)
    local arg = table.pack(...)
    for i = 1, arg.n do printf(" %s", tos(arg[i])) end
    print()
end


-- Parser functions


--[[
local function pattern_parser(pat, src, pos)
    local capture, newpos = string.match(src, pat, pos)
    if newpos then
        return newpos, capture
    else
        return pos
    end
end

local function build_pattern_parser(pat)
    return partial(pattern_parser, pat)
end

local parse_spaces = build_pattern_parser("^([ \t]*)()")
local parse_word = build_pattern_parser("^([^ \t\r\n]+)()")

local parse_eol = build_pattern_parser("^(.-)([\r\n]+)()")
local parse_line = build_pattern_parser("^([^\r\n]*)()")
]]

M.src = ""
M.pos = 1

M.parse_pattern = function(pat)
    local capture, newpos = string.match(M.src, pat, M.pos)
    if newpos then
        M.pos = newpos; return capture
    end
end

M.parse_spaces = partial(M.parse_pattern, "^([ \t]*)()")
M.parse_word = partial(M.parse_pattern, "^([^ \t\r\n]+)()")
M.parse_newline = partial(M.parse_pattern, "^([\r\n]+)()")
M.parse_restofline = partial(M.parse_pattern, "^([^\r\n]*)()")
M.parse_word_or_newline = function() return M.parse_word() or M.parse_newline() end
M.get_word = function()
    M.parse_spaces(); return M.parse_word()
end
M.get_word_or_newline = function()
    M.parse_spaces(); return M.parse_word_or_newline()
end

-- The dictionary (primatives)
M._F = {}
M._F["%L"] = function() eval(M.parse_restofline()) end
M.word = ""

-- The mode processor
M.mode = "interpret"
M.modes = {}
M.run = function()
    while M.mode ~= "stop" do
        M.modes[M.mode]()
    end
end

-- allow the interpreter to handle primitives (lua functions)
M.interpret_primitive = function()
    if type(M._F[M.word]) == "function" then
        M._F[M.word]()
        return true
    end
end

M.modes.interpret = function()
    M.word = M.get_word_or_newline() or ""
    if M.debug then
        M.p_s_i()
    end
    local _ = M.interpret_primitive()
        or M.interpret_nonprimitive()
        or M.interpret_number()
        or error("can't interpret: " .. M.word)
end

-- some basics
M._F["\n"] = function() end
M._F[""] = function() M.mode = "stop" end
M._F["[L"] = function() eval(M.parse_pattern("^(.-)%sL]()")) end
M.DS = { n = 0 }
M.push = function(stack, x)
    stack.n = stack.n + 1; stack[stack.n] = x
end
M.pop = function(stack)
    if stack.n == 0 then
        error("Stack underflow")
        return nil
    end
    local x = stack[stack.n]
    stack[stack.n] = nil
    stack.n = stack.n - 1
    return x
end

-- printing state
M.debug = false
M.d = {}
M.d.q = function(obj)
    if type(obj) == "string" then return string.format("%q", obj) end
    if type(obj) == "number" then return string.format("%s", obj) end
end
M.d.qw = function(obj, w) return string.format("%-" .. w .. "s", M.d.q(obj)) end
M.d.o = function(obj) return string.gsub(M.d.q(obj), "\\\n", "\\n") end
M.d.ow = function(obj, w) return string.gsub(M.d.qw(obj, w), "\\\n", "\\n") end
M.d.arr = function(array) return "{ " .. table.concat(array, " ") .. " }" end
M.d.RS = function(w) return string.format("RS=%-" .. w .. "s", M.d.arr(M.RS)) end
M.d.DS = function(w) return string.format("DS=%-" .. w .. "s", M.d.arr(M.DS)) end
M.d.PS = function(w) return string.format("PS=%-" .. w .. "s", M.d.arr(M.PS)) end
M.d.mode = function(w) return string.format("mode=%-" .. w .. "s", mode) end
M.d.v = function(v)
    local value = M[v]
    if value then
        return v .. "=" .. M.d.o(value)
    end
    return "error cannot find: " .. v
end

M.d.src = function() print((string.gsub(M.src, "\n$", ""))) end
M.d.memory = function()
    print(" memory ="); prettyprint(M.memory)
end

M.d.base = function() return M.d.RS(9) .. M.d.mode(11) .. M.d.DS(11) end

M.p_s_i = function() print(M.d.base() .. M.d.v("word")) end
M.p_s_c = function() print(M.d.base() .. M.d.v("here") .. " " .. M.d.v("word")) end
M.p_s_f = function() print(M.d.base() .. M.d.v("instr")) end
M.p_s_h = function() print(M.d.base() .. M.d.v("head")) end
M.p_s_lit = function() print(M.d.base() .. M.d.v("data")) end
M.p_s_pcell = function() print(M.d.base() .. M.d.v("pdata")) end

M.t = 0
M.d.t = function(w) return string.format("t=%-" .. w .. "d", M.t) end
M.d.tick = function()
    M.t = M.t + 1; return ""
end

-- dictionary
M.d._F = function()
    local tos1 = function(s) return (string.format("%q", s):gsub("\n", "n")) end
    local f = function(k) return string.format("%-10s %s", tos1(k), tos(M._F[k])) end
    return " _F = \n" .. mapconcat(f, sorted(keys(M._F)), "\n")
end

-- memory
M.RS = { n = 0 }
M.memory = { n = 0 }
M.here = 1

M.compile = function(...)
    local args = table.pack(...)
    for i = 1, args.n do
        M.compile1(args[i])
    end
end
M.compile1 = function(x)
    M.memory[M.here] = x
    M.here = M.here + 1
    M.memory.n = math.max(M.memory.n, M.here)
end

-- inner interpreter
M._H = {}
M._H["docol"] = function()
    -- RS[RS.n] = RS[RS.n] + 1
    M.mode = "forth"
end
M._F["exit"] = function()
    M.pop(M.RS)
    if type(M.RS[M.RS.n]) == "string" then
        M.mode = M.pop(M.RS)
    end
end

M.modes.head = function()
    M.head = M.memory[M.RS[M.RS.n]]
    if M.debug then
        M.p_s_h()
    end
    M.RS[M.RS.n] = M.RS[M.RS.n] + 1
    M._H[M.head]()
end

M.modes.forth = function()
    local instr = M.memory[M.RS[M.RS.n]]
    if M.debug then
        M.p_s_f()
    end
    M.RS[M.RS.n] = M.RS[M.RS.n] + 1
    if type(instr) == "number" then
        M.push(M.RS, instr)
        M.mode = "head"
    elseif type(instr) == "string" then
        M._F[instr]()
    else
        error("Can't run forth instruction: " .. tos(instr))
    end
end

M.interpret_nonprimitive = function()
    if type(M._F[M.word]) == "number" then
        M.push(M.RS, "interpret")
        M.push(M.RS, M._F[M.word])
        M.mode = "head"
        return true
    end
end

M._F[":"] = function()
    M._F[M.get_word()] = M.here
    M.compile("docol")
    M.mode = "compile"
end
M._F[";"] = function()
    M.compile("exit")
    M.mode = "interpret"
end

M.IMMEDIATE = {}
M.IMMEDIATE[";"] = true

M.compile_immediate_word = function()
    if M.word and M._F[M.word] and M.IMMEDIATE[M.word] then
        if type(M._F[M.word]) == "function" then
            -- this is a primitive
            M._F[M.word]()
        else
            M.push(M.RS, M.mode)
            M.push(M.RS, M._F[M.word])
            M.mode = "head"
        end
        return true
    end
end

M.compile_nonimmediate_word = function()
    if M.word and M._F[M.word] and not M.IMMEDIATE[M.word] then
        if type(M._F[M.word]) == "function" then
            -- this is a primitive compile its name
            M.compile1(M.word)
        else
            -- non-primitive, compile its address
            M.compile1(M._F[M.word])
        end
        return true
    end
end

M.compile_number = function()
    if M.word and tonumber(M.word) then
        M.compile1("lit")
        M.compile1(tonumber(M.word))
        return true
    end
end

M.modes.compile = function()
    M.word = M.get_word()
    if M.debug then
        M.p_s_c()
    end
    local _ = M.compile_immediate_word()
        or M.compile_nonimmediate_word()
        or M.compile_number()
        or error("Can't compile: " .. (M.word or "EOT"))
end

M.interpret_number = function()
    if M.word and tonumber(M.word) then
        M.push(M.DS, tonumber(M.word))
        return true
    end
end

M._F["lit"] = function()
    M.push(M.DS, M.memory[M.RS[M.RS.n]])
    M.RS[M.RS.n] = M.RS[M.RS.n] + 1
end

M.modes.lit = function()
    local data = M.memory[M.RS[M.RS.n]]
    if M.debug then
        M.p_s_lit()
    end
    M.push(M.DS, M.memory[M.RS[M.RS.n]])
    M.RS[M.RS.n] = M.RS[M.RS.n] + 1
    mode = "forth"
end

M.write = function(str)
    M.output = M.output .. str
end

-- Basic Forth primitives
M._F["."] = function()
    M.write(M.pop(M.DS) .. " ")
end
M._F[".s"] = function()
    for i = 1, M.DS.n do
        M.write(M.DS[i] .. " ")
    end
end
M._F["drop"] = function() local _ = M.pop(M.DS) end
M._F["2drop"] = function()
    local _ = M.pop(M.DS)
    local _ = M.pop(M.DS)
end
M._F["swap"] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, a)
    M.push(M.DS, b)
end
M._F["2swap"] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    local c = M.pop(M.DS)
    local d = M.pop(M.DS)
    M.push(M.DS, b)
    M.push(M.DS, a)
    M.push(M.DS, d)
    M.push(M.DS, c)
end
M._F["dup"] = function()
    local a = M.pop(M.DS)
    M.push(M.DS, a)
    M.push(M.DS, a)
end
M._F["2dup"] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, b)
    M.push(M.DS, a)
    M.push(M.DS, b)
    M.push(M.DS, a)
end
M._F["?dup"] = function()
    local a = M.pop(M.DS)
    if a ~= 0 then
        M.push(M.DS, a)
    end
    M.push(M.DS, a)
end
M._F["over"] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, a)
    M.push(M.DS, b)
    M.push(M.DS, a)
end
M._F["rot"] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    local c = M.pop(M.DS)
    M.push(M.DS, a)
    M.push(M.DS, c)
    M.push(M.DS, b)
end
M._F["-rot"] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    local c = M.pop(M.DS)
    M.push(M.DS, b)
    M.push(M.DS, a)
    M.push(M.DS, c)
end

-- arithmetic
M._F["+"] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, b + a)
end
M._F["-"] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, b - a)
end
M._F["*"] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, b * a)
end
M._F["/"] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, b / a)
end

-- conditionals
M._F["="] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, b == a)
end
M._F["!="] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, b ~= a)
end
M._F["<"] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, b < a)
end
M._F[">"] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, b > a)
end
M._F["<="] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, b <= a)
end
M._F[">="] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, b >= a)
end
M._F["and"] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, b and a)
end
M._F["or"] = function()
    local a = M.pop(M.DS)
    local b = M.pop(M.DS)
    M.push(M.DS, b or a)
end
M._F["not"] = function()
    local a = M.pop(M.DS)
    M.push(M.DS, not a)
end

return M
