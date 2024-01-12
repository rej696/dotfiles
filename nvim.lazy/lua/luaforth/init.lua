Forth = require("luaforth.forth")

-- TODO embed tcc.lua (https://github.com/nucular/tcclua)
-- and luajit.ffi (http://luajit.org/ext_ffi.html) to be able
-- to define and declare and compile C functions in the forth interpreter,
-- to enable a sort of C repl?
-- Luajit.ffi and lua bitop (https://bitop.luajit.org/api.html) are installed in neovim
-- luajit, and can be used by running require("bit") or require("ffi")

-- TODO save memory (i.e. defined words) and load memory

return {
    debug = function(debug)
        Forth.debug = debug
    end,
    run = function(str)
        Forth.pos = 1
        Forth.mode = "interpret"
        Forth.src = str
        Forth.run()
        print("OK")
        Forth.print()
    end,
    prompt = function()
        Forth.pos = 1
        Forth.mode = "interpret"
        Forth.src = vim.fn.input("Forth: ")
        print(" OK")
        Forth.run()
        Forth.print()
    end,
    reset = function()
        -- reload Forth object and luaforth.forth module
        package.loaded["_G"]["Forth"] = nil
        package.loaded["luaforth.forth"] = nil
        Forth = require("luaforth.forth")
    end
}

