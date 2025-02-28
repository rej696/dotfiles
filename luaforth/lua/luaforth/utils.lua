local M = {}

function M.split(str, pat)
    local t = {}
    local f = function(word) table.insert(t, word) end
    local _ = string.gsub(str, pat or "([^%s]+)", f)
    return t
end

---@param str string
function M.eval(str)
    return assert(loadstring(str))()
end

function M.printf(...) M.write(string.format(...)) end

function M.partial(f, arg)
    return function(...)
        return f(arg, ...)
    end
end

function M.map(f, t)
    local ret = {}
    for k, v in pairs(t) do
        ret[k] = f(v)
    end
    return ret
end

function M.ipairs_map(f, t)
    local g = function(a, i)
        i = i + 1
        local v = a[i]
        if v then
            return i, f(v)
        end
    end
    return g, t, 0
end

function M.pairs_map(f, t)
    local g = function(a, b)
        local k, v = next(a, b)
        if k then
            return k, f(v)
        end
    end
    return g, t, nil
end

M.mapconcat = function(f, A, sep)
    return table.concat(M.map(f, A), sep)
end

M.sorted = function(tbl, lt)
    table.sort(tbl, lt); return tbl
end

M.keys = function(tbl)
    local ks = {}
    for k, _ in pairs(tbl) do table.insert(ks, k) end
    return ks
end

-- pretty print functions
M.tos_compare_pairs = function(pair1, pair2)
    local key1, key2   = pair1.key, pair2.key
    local type1, type2 = type(key1), type(key2)
    if type1 == type2 then
        if type1 == "number" then return key1 < key2 end
        if type1 == "string" then return key1 < key2 end
        return tostring(key1) < tostring(key2) -- fast
    else
        return type1 < type2                   -- numbers before strings before tables, etc
    end
end

M.tos_sorted_pairs = function(T)
    local Tpairs = {}
    for key, val in pairs(T) do
        table.insert(Tpairs, { key = key, val = val })
    end
    table.sort(Tpairs, M.tos_compare_pairs)
    return Tpairs
end

M.tos_pair = function(pair)
    return M.tos(pair.key) .. "=" .. M.tos(pair.val)
end

M.tos_table = function(T, sep)
    return "{" .. M.mapconcat(M.tos_pair, M.tos_sorted_pairs(T), sep or ", ") .. "}"
end

M.tos = function(o)
    local t = type(o)
    if t == "number" then return tostring(o) end
    if t == "string" then return string.format("%q", o) end
    if t == "table" then return M.tos_table(o) end
    return "<" .. tostring(o) .. ">"
end


M.prettyprint = function(...)
    local arg = table.pack(...)
    for i = 1, arg.n do M.printf(" %s", M.tos(arg[i])) end
    print()
end

M.stringify = function(o)
    local t = type(o)
    if t == "number" then return tostring(o) end
    if t == "string" then return string.format("%q", o) end
    if t == "table" then return "{ " .. M.mapconcat(M.stringify, o, " ") .. " }" end
    return "<" .. tostring(o) .. ">"
end

return M
