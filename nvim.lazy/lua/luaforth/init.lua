Forth = require("luaforth.forth")

-- TODO embed tcc.lua (https://github.com/nucular/tcclua)
-- and luajit.ffi (http://luajit.org/ext_ffi.html) to be able
-- to define and declare and compile C functions in the forth interpreter,
-- to enable a sort of C repl?
-- Luajit.ffi and lua bitop (https://bitop.luajit.org/api.html) are installed in neovim
-- luajit, and can be used by running require("bit") or require("ffi")

-- TODO save memory (i.e. defined words) and load memory

local forth_setup = function(str)
    Forth.pos = 1
    Forth.mode = "interpret"
    Forth.src = str
end

local forth_run = function()
    Forth.run()
    local output = Forth.read_output()
    local ok = " OK"
    if Forth.print_stack then
        Forth._F[".s"]()
        ok = " OK<" .. Forth.read_output() ..">"
    end
    if output ~= "" then
        if (#ok + #output) > 20 then
            vim.print(ok)
            vim.print(Forth.output_prompt .. output)
        else
            vim.print(ok .. Forth.output_prompt .. output)
        end
    else
        vim.print(ok)
    end
end

return {
    debug = function(debug)
        Forth.debug = debug
    end,
    setup = function(t)
        Forth.input_prompt = t.input_prompt or Forth.input_prompt
        Forth.output_prompt = t.output_prompt or Forth.output_prompt
        Forth.print_stack = t.print_stack
    end,
    run = function(str)
        forth_setup(str)
        Forth.run()
        print(Forth.read_output() .. " OK")
    end,
    prompt = function()
        forth_setup(vim.fn.input(Forth.input_prompt))
        forth_run()
    end,
    repl = function()
        while true do
            forth_setup(vim.fn.input(Forth.input_prompt))
            if Forth.src == "" or Forth.src == "bye" then
                break
            end
            forth_run()
        end
    end,
    reset = function()
        -- reload Forth object and luaforth.forth module
        package.loaded["_G"]["Forth"] = nil
        package.loaded["luaforth.forth"] = nil
        Forth = require("luaforth.forth")
    end
}
