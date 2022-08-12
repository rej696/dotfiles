local modes = require "modes"
local settings = require "settings"

modes.add_binds("all", {
    { "<Scroll>", "Scroll the current page.", function (w, o)
local settings = require "settings"
        w:scroll { yrel = settings.window.scroll_step * o.dy }
    end },
})

settings.window.home_page = "duckduckgo.com"

settings.window.search_engines.default = settings.window.search_engines.duckduckgo
