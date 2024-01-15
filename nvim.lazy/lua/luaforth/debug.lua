local M = {}
local utils = require('luaforth.utils')

M = {}
M.q = function(obj)
    if type(obj) == "string" then return string.format("%q", obj) end
    if type(obj) == "number" then return string.format("%s", obj) end
end
M.qw = function(obj, w) return string.format("%-" .. w .. "s", M.q(obj)) end
M.o = function(obj) return string.gsub(M.q(obj), "\\\n", "\\n") end
M.ow = function(obj, w) return string.gsub(M.qw(obj, w), "\\\n", "\\n") end
M.arr = function(array) return "{ " .. table.concat(array, " ") .. " }" end
M.RS = function(RS, w) return string.format("RS=%-" .. w .. "s", M.arr(RS)) end
M.DS = function(DS, w) return string.format("DS=%-" .. w .. "s", M.arr(DS)) end
M.PS = function(PS, w) return string.format("PS=%-" .. w .. "s", M.arr(PS)) end
M.mode = function(mode, w) return string.format("mode=%-" .. w .. "s", mode) end
M.v = function(forth, v)
    local value = forth[v]
    if value then
        return v .. "=" .. M.o(value)
    end
    return "error cannot find: " .. v
end

M.src = function(forth) print((string.gsub(forth.src, "\n$", ""))) end
M.memory = function(forth)
    print(" memory ="); utils.prettyprint(forth.memory)
end

M.base = function(forth) return M.RS(forth.RS, 9) .. M.mode(forth.mode, 11) .. M.DS(forth.DS, 11) end

M.p_s_i = function(forth) print(M.base(forth) .. M.v(forth, "word")) end
M.p_s_c = function(forth) print(M.base(forth) .. M.v(forth, "here") .. " " .. M.v(forth, "word")) end
M.p_s_f = function(forth) print(M.base(forth) .. M.v(forth, "instr")) end
M.p_s_h = function(forth) print(M.base(forth) .. M.v(forth, "head")) end
M.p_s_lit = function(forth) print(M.base(forth) .. M.v(forth, "data")) end
M.p_s_pcell = function(forth) print(M.base(forth) .. M.v(forth, "pdata")) end

M.t = function(t, w) return string.format("t=%-" .. w .. "d", t) end
M.tick = function(forth)
    forth.t = forth.t + 1; return ""
end

M._F = function(forth)
    local tos1 = function(s) return (string.format("%q", s):gsub("\n", "n")) end
    local f = function(k) return string.format("%-10s %s", tos1(k), utils.tos(forth._F[k])) end
    return " _F = \n" .. utils.mapconcat(f, utils.sorted(utils.keys(forth._F)), "\n")
end

return M
