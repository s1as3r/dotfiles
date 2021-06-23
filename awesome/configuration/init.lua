local awful = require("awful")
local gears = require('gears')
local gfs = gears.filesystem
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local bling = require('module.bling')

-- Set Autostart Applications
require("configuration.autostart")

-- Default Applications
terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " start " .. editor
browser = "google-chrome-stable"
filemanager = "thunar"
discord = "discord"
launcher = "rofi -show drun"
music = terminal .. ' start --class music ncmpcpp'

-- Global Vars
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"
shift = "Shift"
ctrl = "Control"

local yy = 10 + beautiful.wibar_height

-- Enable Playerctl Module from Bling
bling.signal.playerctl.enable {
    -- ignore = "firefox", 
    update_on_activity = true
}

bling.widget.tag_preview.enable {
    show_client_content = true,
    x = dpi(10),
    y = dpi(10) + beautiful.wibar_height,
    scale = 0.25,
    honor_padding = true,
    honor_workarea = false
}

-- Set Wallpaper
screen.connect_signal("request::wallpaper", function(s)
    gears.wallpaper.maximized(beautiful.wallpaper, s, false, nil)
    -- gears.wallpaper.set(beautiful.xbackground)
end)

-- Get Keybinds
require("configuration.keys")

-- Get Rules
require("configuration.ruled")

-- Layouts and Window Stuff
require("configuration.window")

-- Scratchpad
-- require("module.scratchpad")
require("configuration.scratchpad")
