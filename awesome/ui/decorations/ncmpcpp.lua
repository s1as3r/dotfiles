local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local helpers = require("helpers")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local art = wibox.widget {
    image = gears.filesystem.get_configuration_dir() .. "images/no_music.png",
    resize = true,
    forced_height = dpi(250),
    forced_width = dpi(250),
    widget = wibox.widget.imagebox
}

local create_button = function(symbol, color, command, playpause)

    local icon = wibox.widget {
        markup = helpers.colorize_text(symbol, color),
        font = beautiful.icon_font_name .. "15",
        align = "center",
        valigin = "center",
        widget = wibox.widget.textbox()
    }

    local button = wibox.widget {
        icon,
        forced_height = dpi(40),
        forced_width = dpi(40),
        bg = beautiful.xcolor0,
        shape = gears.shape.squircle,
        widget = wibox.container.background
    }

    awesome.connect_signal("bling::playerctl::status", function(playing)
        if playpause then
            if playing then
                icon.markup = helpers.colorize_text("", color)
            else
                icon.markup = helpers.colorize_text("", color)
            end
        end
    end)

    button:buttons(gears.table.join(
                       awful.button({}, 1, function() command() end)))

    button:connect_signal("mouse::enter", function()
        icon.markup = helpers.colorize_text(icon.text, beautiful.xforeground)
    end)

    button:connect_signal("mouse::leave", function()
        icon.markup = helpers.colorize_text(icon.text, color)
    end)

    return button
end

-- Get Song Info 
awesome.connect_signal("bling::playerctl::title_artist_album",
                       function(title, artist, art_path)
    -- Set art widget
    art:set_image(gears.surface.load_uncached(art_path))
end)

local play_command =
    function() awful.spawn.with_shell("playerctl play-pause") end
local prev_command = function() awful.spawn.with_shell("playerctl previous") end
local next_command = function() awful.spawn.with_shell("playerctl next") end

local playerctl_play_symbol = create_button("", beautiful.xcolor4,
                                            play_command, true)

local playerctl_prev_symbol = create_button("玲", beautiful.xcolor4,
                                            prev_command, false)
local playerctl_next_symbol = create_button("怜", beautiful.xcolor4,
                                            next_command, false)

emacs_tb = function(c)
    awful.titlebar(c,
                   {position = "right", size = 400, bg = beautiful.xbackground}):setup{

        {
            {
                {
                    art,
                    bg = beautiful.xcolor1,
                    shape = helpers.rrect(20),
                    widget = wibox.container.background
                },
                top = dpi(40),
                widget = wibox.container.margin
            },
            halign = "center",
            widget = wibox.container.place
        },
        {
            {
                {
                    playerctl_prev_symbol,
                    playerctl_play_symbol,
                    playerctl_next_symbol,
                    spacing = dpi(40),
                    layout = wibox.layout.fixed.horizontal
                },
                top = dpi(60),
                widget = wibox.container.margin
            },
            halign = "center",
            widget = wibox.container.place
        },
        layout = wibox.layout.fixed.vertical
    }

    awful.titlebar(c, nil):setup{}
end

table.insert(awful.rules.rules, {
    rule_any = {class = {"music"}, instance = {"music"}},
    properties = {},
    callback = emacs_tb
})

return emacs_tb
