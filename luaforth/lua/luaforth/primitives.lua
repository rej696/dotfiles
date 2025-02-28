local M = Forth

-- Basic Forth Primitives

M._F["."] = function()
    M.write(M.pop(M.DS))
end
M._F[".s"] = function()
    for i = 1, M.DS.n do
        M.write(M.DS[i])
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
