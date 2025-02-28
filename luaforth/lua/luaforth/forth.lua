-- Based on http://angg.twu.net/miniforth/miniforth6.lua
local utils = require('luaforth.utils')
local M = {}

M.d = require('luaforth.debug')

-- Parser functions
function M:parse_pattern(pat)
    local capture, newpos = string.match(self.src, pat, self.pos)
    if newpos then
        M.pos = newpos; return capture
    end
end

function M:parse_spaces() return self:parse_pattern("^([ \t]*)()") end

function M:parse_word() return self:parse_pattern("^([^ \t\r\n]+)()") end

function M:parse_newline() return self:parse_pattern("^([\r\n]+)()") end

function M:parse_restofline() return self:parse_pattern("^([^\r\n]*)()") end

function M:parse_to_symbol(delim) return self:parse_pattern("^(.-)%s" .. delim .. "()") end

function M:parse_word_or_newline() return self:parse_word() or self:parse_newline() end

function M:get_word()
    self:parse_spaces(); return self:parse_word()
end

function M:get_word_or_newline()
    self:parse_spaces(); return self:parse_word_or_newline()
end

-- Core Fields
M.src = ""
M.pos = 1
M.word = ""
M.t = 0
M.DS = { n = 0 }
M.RS = { n = 0 }
M.memory = { n = 0 }
M.here = 1

-- Stack Manipulation
M.push = function(stack, x)
    stack.n = stack.n + 1; stack[stack.n] = x
end
M.peek = function(stack)
    return stack[stack.n]
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

-- Primatives
M._F = {}
M._F["%L"] = function() utils.eval(M:parse_restofline()) end
M._F["\n"] = function() end
M._F[""] = function() M.mode = "stop" end
-- M._F["[L"] = function() eval(M.parse_pattern("^(.-)%sL]()")) end
M._F["[L"] = function() utils.eval(M:parse_to_symbol("L]")) end

-- The mode processor
M.mode = "interpret"
M.modes = {}
M.run = function()
    while M.mode ~= "stop" do
        M.modes[M.mode]()
    end
end

-- Interpreter Mode
M.interpret_primitive = function()
    if type(M._F[M.word]) == "function" then
        M._F[M.word]()
        return true
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

M.interpret_number = function()
    if M.word and tonumber(M.word) then
        M.push(M.DS, tonumber(M.word))
        return true
    end
end

M.interpret_string = function()
    if M.word and type(M.word) == "string"
        and (string.match(M.word, '^"(.-)"$')
            or string.match(M.word, ":(.-)$")) then
        M.push(M.DS, tostring(M.word))
        return true
    end
end

M.modes.interpret = function()
    M.word = M:get_word_or_newline() or ""
    if M.debug then
        M.d.p_s_i(M)
    end
    local _ = M.interpret_primitive()
        or M.interpret_nonprimitive()
        or M.interpret_number()
        or M.interpret_string()
        or error("can't interpret: " .. M.word)
end


-- Compiling / Word definition
M.compile = function(...)
    local args = { ... }
    for i = 1, #args do
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
        M.d.p_s_h()
    end
    M.RS[M.RS.n] = M.RS[M.RS.n] + 1
    M._H[M.head]()
end

M.modes.forth = function()
    local instr = M.memory[M.RS[M.RS.n]]
    if M.debug then
        M.d.p_s_f()
    end
    M.RS[M.RS.n] = M.RS[M.RS.n] + 1
    if type(instr) == "number" then
        M.push(M.RS, instr)
        M.mode = "head"
    elseif type(instr) == "string" then
        M._F[instr]()
    else
        error("Can't run forth instruction: " .. utils.tos(instr))
    end
end

M._F[":"] = function()
    M._F[M:get_word()] = M.here
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

M.compile_string = function()
    if M.word and type(M.word) == "string"
        and (string.match(M.word, '^"(.-)"$')
            or string.match(M.word, ":(.-)$")) then
        M.compile1("lit")
        M.compile1(tostring(M.word))
        return true
    end
end

M.modes.compile = function()
    M.word = M:get_word()
    if M.debug then
        M.d.p_s_c()
    end
    local _ = M.compile_immediate_word()
        or M.compile_nonimmediate_word()
        or M.compile_number()
        or M.compile_string()
        or error("Can't compile: " .. (M.word or "EOT"))
end

M._F["lit"] = function()
    M.push(M.DS, M.memory[M.RS[M.RS.n]])
    M.RS[M.RS.n] = M.RS[M.RS.n] + 1
end

M.modes.lit = function()
    local data = M.memory[M.RS[M.RS.n]]
    if M.debug then
        M.d.p_s_lit()
    end
    M.push(M.DS, M.memory[M.RS[M.RS.n]])
    M.RS[M.RS.n] = M.RS[M.RS.n] + 1
    M.mode = "forth"
end

-- printing
M.input_prompt = "Forth: "
M.output_prompt = " -> "
M.output = {}
M.write = function(o)
    local str = o
    if type(o) ~= "string" then
        str = tostring(o)
    end
    table.insert(M.output, str)
end

M.read_output = function()
    local output = table.concat(M.output, " ")
    M.output = {}
    return output or ""
end

return M
