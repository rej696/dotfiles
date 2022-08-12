--------------------------
-- Default luakit theme --
--------------------------

local theme = {}
local black = "#272822"
local red = "#F92672"
local green = "#A6E22E"
local yellow = "#F4BF75"
local blue = "#66D9EF"
local magenta = "#AE81FF"
local cyan = "#A1EFE4"
local white = "#F8F8F0"

-- Default settings
theme.font = "14px Hack"
theme.fg   = "#F8F8F0"
theme.bg   = "#272A30"

-- Genaral colours
theme.success_fg = blue
theme.loaded_fg  = magenta
theme.error_fg = red
theme.error_bg = bg

-- Warning colours
theme.warning_fg = yellow
theme.warning_bg = bg

-- Notification colours
theme.notif_fg = magenta
theme.notif_bg = bg

-- Menu colours
theme.menu_fg                   = theme.fg
theme.menu_bg                   = theme.bg
theme.menu_selected_fg          = yellow
theme.menu_selected_bg          = theme.bg
theme.menu_title_bg             = theme.bg
theme.menu_primary_title_fg     = red
theme.menu_secondary_title_fg   = yellow

theme.menu_disabled_fg = "#999"
theme.menu_disabled_bg = theme.menu_bg
theme.menu_enabled_fg = theme.menu_fg
theme.menu_enabled_bg = theme.menu_bg
theme.menu_active_fg = cyan
theme.menu_active_bg = theme.menu_bg

-- Proxy manager
theme.proxy_active_menu_fg      = theme.fg
theme.proxy_active_menu_bg      = theme.bg
theme.proxy_inactive_menu_fg    = theme.fg
theme.proxy_inactive_menu_bg    = theme.bg

-- Statusbar specific
theme.sbar_fg         = theme.fg
theme.sbar_bg         = theme.bg

-- Downloadbar specific
theme.dbar_fg         = theme.fg
theme.dbar_bg         = theme.bg
theme.dbar_error_fg   = red

-- Input bar specific
theme.ibar_fg           = theme.fg
theme.ibar_bg           = theme.bg

-- Tab label
theme.tab_fg            = theme.fg
theme.tab_bg            = theme.bg
theme.tab_hover_bg      = theme.bg
theme.tab_ntheme        = theme.bg
theme.selected_fg       = yellow
theme.selected_bg       = theme.bg
theme.selected_ntheme   = theme.bg
theme.loading_fg        = theme.fg
theme.loading_bg        = theme.bg

theme.selected_private_tab_bg = "#3d295b"
theme.private_tab_bg    = "#22254a"

-- Trusted/untrusted ssl colours
theme.trust_fg          = green
theme.notrust_fg        = red

-- Follow mode hints
theme.hint_font = "14px Hack, courier, sans-serif"
theme.hint_fg = theme.fg
theme.hint_bg = theme.bg
theme.hint_border = "1px dashed #000"
theme.hint_opacity = "0.3"
theme.hint_overlay_bg = "rgba(255,255,153,0.3)"
theme.hint_overlay_border = "1px dotted #000"
theme.hint_overlay_selected_bg = "rgba(0,255,0,0.3)"
theme.hint_overlay_selected_border = theme.hint_overlay_border

-- General colour pairings
theme.ok = { fg = theme.fg, bg = theme.bg }
theme.warn = { fg = yellow, bg = theme.bg }
theme.error = { fg = red, bg = theme.bg }

-- Gopher page style (override defaults)
theme.gopher_light = { bg = "#E8E8E8", fg = "#17181C", link = "#03678D" }
theme.gopher_dark  = { bg = "#17181C", fg = "#E8E8E8", link = "#f90" }

return theme

-- vim: et:sw=4:ts=8:sts=4:tw=80
