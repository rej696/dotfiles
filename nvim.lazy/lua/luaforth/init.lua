local forth = require("luaforth.forth")

return {
    debug = function(debug)
        forth.debug = debug
    end,
    run = function(str)
        forth.pos = 1
        forth.mode = "interpret"
        forth.output = ""
        forth.src = str
        forth.run()
        print(forth.output .. " OK")
    end,
    prompt = function()
        forth.pos = 1
        forth.mode = "interpret"
        forth.output = ""
        forth.src = vim.fn.input("Forth: ")
        print(" OK")
        forth.run()
        print(forth.output)
    end,
    reset = function()
        forth = require("luaforth.forth")
    end
}

