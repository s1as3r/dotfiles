local awful = require("awful")
local beautiful = require("beautiful")

emacs_tb = function(c)
    awful.titlebar(c, {position = "left", size = 30, bg = beautiful.xbackground})
    awful.titlebar(c, {position = "top", size = 30, bg = beautiful.xbackground})
    awful.titlebar(c,
                   {position = "bottom", size = 30, bg = beautiful.xbackground})
    awful.titlebar(c,
                   {position = "right", size = 30, bg = beautiful.xbackground})
end

table.insert(awful.rules.rules, {
    rule_any = {class = {"Emacs"}, instance = {"emacs"}},
    properties = {},
    callback = emacs_tb
})
