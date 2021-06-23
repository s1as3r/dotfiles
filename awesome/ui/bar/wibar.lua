-- wibar.lua
-- Wibar (top bar)
local awful = require("awful")
local gears = require("gears")
local gfs = require("gears.filesystem")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local helpers = require("helpers")

local systray_margin = (beautiful.wibar_height - beautiful.systray_icon_size) /
                           2

-- Awesome Panel -----------------------------------------------------------

local icon1 = wibox.widget {
    widget = wibox.widget.imagebox,
    image = gears.surface.load_uncached(gfs.get_configuration_dir() ..
                                            "icons/ghosts/awesome.png"),
    resize = true
}

local awesome_icon = wibox.widget {
    {
        icon1,
        top = dpi(5),
        bottom = dpi(5),
        left = dpi(10),
        right = dpi(5),
        widget = wibox.container.margin
    },
    bg = beautiful.xcolor0,
    widget = wibox.container.background
}

awesome_icon:buttons(gears.table.join(awful.button({}, 1, function()
    awesome.emit_signal("widgets::start::toggle", mouse.screen)
end)))

--[[ awesome.connect_signal("widgets::start::status", function(status)
    if not status then
        icon1.image = unclicked
    else
        icon1.image = clicked
    end
end)
--]]

-- Battery Bar Widget ---------------------------------------------------------

local battery_bar = wibox.widget {
    max_value = 100,
    value = 70,
    forced_width = dpi(60),
    shape = helpers.rrect(beautiful.border_radius - 3),
    bar_shape = helpers.rrect(beautiful.border_radius - 3),
    color = beautiful.xcolor8,
    background_color = beautiful.xcolor0,
    border_width = dpi(0),
    border_color = beautiful.border_color,
    widget = wibox.widget.progressbar
}

local battery_text = wibox.widget {
    font = beautiful.font,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local battery_icon = wibox.widget {
    font = beautiful.icon_font_name .. "10",
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local battery_pill = wibox.widget {
    battery_bar,
    {
        {
            {battery_icon, top = dpi(1), widget = wibox.container.margin},
            helpers.horizontal_pad(10),
            {battery_text, top = dpi(1), widget = wibox.container.margin},
            layout = wibox.layout.fixed.horizontal

        },
        halign = true,
        widget = wibox.container.place
    },
    layout = wibox.layout.stack
}

awesome.connect_signal("signal::battery", function(value)
    battery_bar.value = value

    local bat_icon = ''

    if value >= 90 and value <= 100 then
        bat_icon = ''
    elseif value >= 70 and value < 90 then
        bat_icon = ''
    elseif value >= 60 and value < 70 then
        bat_icon = ''
    elseif value >= 50 and value < 60 then
        bat_icon = ''
    elseif value >= 30 and value < 50 then
        bat_icon = ''
    elseif value >= 15 and value < 30 then
        bat_icon = ''
    else
        bat_icon = ''
    end

    battery_icon.markup = "<span foreground='" .. beautiful.xcolor12 .. "'>" ..
                              bat_icon .. "</span>"
    battery_text.markup = "<span foreground='" .. beautiful.xcolor12 .. "'>" ..
                              value .. '%' .. "</span>"
end)

-- Timer for charging animation
local q = 0
local g = gears.timer {
    timeout = 0.03,
    call_now = false,
    autostart = false,
    callback = function()
        if q >= 100 then q = 0 end
        q = q + 1
        battery_bar.value = q
    end
}

-- The charging animation
local running = false
awesome.connect_signal("signal::charger", function(plugged)
    if plugged then
        g:again()
        running = true
    else
        if running then
            g:stop()
            running = false
        end
    end
end)

-- Date Widget ----------------------------------------------------------------

local date_text = wibox.widget {
    font = beautiful.font,
    format = "%m/%d/%y",
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textclock
}

date_text.markup = "<span foreground='" .. beautiful.xcolor11 .. "'>" ..
                       date_text.text .. "</span>"

date_text:connect_signal("widget::redraw_needed", function()
    date_text.markup = "<span foreground='" .. beautiful.xcolor11 .. "'>" ..
                           date_text.text .. "</span>"
end)

local date_icon = wibox.widget {
    font = beautiful.icon_font_name .. "12",
    markup = "<span foreground='" .. beautiful.xcolor11 .. "'></span>",
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local date_pill = wibox.widget {
    {
        {date_icon, top = dpi(1), widget = wibox.container.margin},
        helpers.horizontal_pad(10),
        {date_text, top = dpi(1), widget = wibox.container.margin},
        layout = wibox.layout.fixed.horizontal
    },
    left = dpi(10),
    right = dpi(10),
    widget = wibox.container.margin
}

-- Time Widget ----------------------------------------------------------------

local time_text = wibox.widget {
    font = beautiful.font,
    format = "%l:%M %P",
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textclock
}

time_text.markup = "<span foreground='" .. beautiful.xcolor5 .. "'>" ..
                       time_text.text .. "</span>"

time_text:connect_signal("widget::redraw_needed", function()
    time_text.markup = "<span foreground='" .. beautiful.xcolor5 .. "'>" ..
                           time_text.text .. "</span>"
end)

local time_icon = wibox.widget {
    font = beautiful.icon_font_name .. "12",
    markup = "<span foreground='" .. beautiful.xcolor5 .. "'></span>",
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local time_pill = wibox.widget {
    {
        {time_icon, top = dpi(1), widget = wibox.container.margin},
        helpers.horizontal_pad(10),
        {time_text, top = dpi(1), widget = wibox.container.margin},
        layout = wibox.layout.fixed.horizontal
    },
    left = dpi(10),
    right = dpi(10),
    widget = wibox.container.margin
}

-- Systray Widget -------------------------------------------------------------

local mysystray = wibox.widget.systray()
mysystray:set_base_size(beautiful.systray_icon_size)

local mysystray_container = {
    mysystray,
    left = dpi(8),
    right = dpi(8),
    widget = wibox.container.margin
}

-- Tasklist Buttons -----------------------------------------------------------

local tasklist_buttons = gears.table.join(
                             awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", {raise = true})
        end
    end), awful.button({}, 3, function()
        awful.menu.client_list({theme = {width = 250}})
    end), awful.button({}, 4, function() awful.client.focus.byidx(1) end),
                             awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end))

-- Playerctl Bar Widget -------------------------------------------------------

-- Title Widget
local song_title = wibox.widget {
    markup = 'Nothing Playing',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local song_artist = wibox.widget {
    markup = 'nothing playing',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local song_logo = wibox.widget {
    markup = '<span foreground="' .. beautiful.xcolor6 .. '"></span>',
    font = beautiful.icon_font_name .. 12,
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

local playerctl_bar = wibox.widget {
    {
        {
            {
                song_logo,
                top = dpi(3),
                left = dpi(3),
                right = dpi(10),
                bottom = dpi(1),
                widget = wibox.container.margin
            },
            {
                {
                    song_title,
                    expand = "outside",
                    layout = wibox.layout.align.vertical
                },
                top = dpi(1),
                left = dpi(10),
                right = dpi(10),
                widget = wibox.container.margin
            },
            {
                {
                    song_artist,
                    expand = "outside",
                    layout = wibox.layout.align.vertical
                },
                top = dpi(1),
                left = dpi(10),
                widget = wibox.container.margin
            },
            spacing = 1,
            spacing_widget = {
                bg = beautiful.xcolor8,
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.horizontal
        },
        left = dpi(10),
        right = dpi(10),
        widget = wibox.container.margin
    },

    bg = beautiful.xcolor0,
    shape = helpers.rrect(beautiful.border_radius - 3),
    widget = wibox.container.background
}

playerctl_bar.visible = false

awesome.connect_signal("bling::playerctl::no_players",
                       function() playerctl_bar.visible = false end)

-- Get Title 
awesome.connect_signal("bling::playerctl::title_artist_album",
                       function(title, artist, _)

    playerctl_bar.visible = true
    song_title.markup = '<span foreground="' .. beautiful.xcolor5 .. '">' ..
                            title .. '</span>'

    song_artist.markup = '<span foreground="' .. beautiful.xcolor4 .. '">' ..
                             artist .. '</span>'
end)

-- Create the Wibar -----------------------------------------------------------

screen.connect_signal("request::desktop_decoration", function(s)
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create layoutbox widget
    s.mylayoutbox = awful.widget.layoutbox(s)

    -- Create the wibox
    s.mywibox = awful.wibar({position = "top", screen = s, type = "dock"})

    -- Remove wibar on full screen
    local function remove_wibar(c)
        if c.fullscreen or c.maximized then
            c.screen.mywibox.visible = false
        else
            c.screen.mywibox.visible = true
        end
    end

    -- Remove wibar on full screen
    local function add_wibar(c)
        if c.fullscreen or c.maximized then
            c.screen.mywibox.visible = true
        end
    end

    -- Hide bar when a splash widget is visible
    awesome.connect_signal("widgets::splash::visibility", function(vis)
        screen.primary.mywibox.visible = not vis
    end)

    client.connect_signal("property::fullscreen", remove_wibar)

    client.connect_signal("request::unmanage", add_wibar)

    -- Create the taglist widget
    s.mytaglist = require("ui.widgets.pacman_taglist")(s)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        bg = beautiful.xcolor0,
        style = {bg = beautiful.xcolor0},
        layout = {
            spacing = dpi(0),
            spacing_widget = {
                bg = beautiful.xcolor8,
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    nil,
                    awful.widget.clienticon,
                    nil,
                    layout = wibox.layout.fixed.horizontal
                },
                top = dpi(5),
                bottom = dpi(5),
                left = dpi(10),
                right = dpi(10),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background
        }
    }

    local final_systray = wibox.widget {
        {mysystray_container, top = dpi(5), layout = wibox.container.margin},
        bg = beautiful.xcolor0,
        shape = helpers.rrect(beautiful.border_radius - 3),
        widget = wibox.container.background
    }

    -- Add widgets to the wibox
    s.mywibox:setup{
        layout = wibox.layout.align.vertical,
        nil,
        {
            layout = wibox.layout.align.horizontal,
            expand = "none",
            {
                layout = wibox.layout.fixed.horizontal,
                {
                    {
                        {
                            awesome_icon,
                            s.mytaglist,
                            spacing = 15,
                            spacing_widget = {
                                color = beautiful.xcolor8,
                                shape = gears.shape.powerline,
                                widget = wibox.widget.separator
                            },
                            layout = wibox.layout.fixed.horizontal
                        },
                        bg = beautiful.xcolor0,
                        shape = helpers.rrect(beautiful.border_radius - 3),
                        widget = wibox.container.background
                    },
                    top = dpi(6),
                    left = dpi(10),
                    right = dpi(5),
                    bottom = dpi(6),
                    widget = wibox.container.margin
                },
                s.mypromptbox,
                {
                    playerctl_bar,
                    top = dpi(6),
                    left = dpi(5),
                    bottom = dpi(6),
                    right = dpi(5),
                    widget = wibox.container.margin
                }
            },
            {
                {
                    {
                        s.mytasklist,
                        bg = beautiful.xcolor0 .. "00",
                        shape = helpers.rrect(beautiful.border_radius - 3),
                        widget = wibox.container.background
                    },
                    top = dpi(6),
                    left = dpi(5),
                    bottom = dpi(6),
                    right = dpi(5),
                    widget = wibox.container.margin
                },
                widget = wibox.container.constraint
            },
            {
                {
                    {
                        time_pill,
                        bg = beautiful.xcolor0,
                        shape = helpers.rrect(beautiful.border_radius - 3),
                        widget = wibox.container.background
                    },
                    top = dpi(6),
                    left = dpi(5),
                    bottom = dpi(6),
                    right = dpi(5),
                    widget = wibox.container.margin
                },

                {
                    {
                        date_pill,
                        bg = beautiful.xcolor0,
                        shape = helpers.rrect(beautiful.border_radius - 3),
                        widget = wibox.container.background
                    },
                    top = dpi(6),
                    left = dpi(5),
                    bottom = dpi(6),
                    right = dpi(5),
                    widget = wibox.container.margin
                },
                {
                    {
                        battery_pill,
                        bg = beautiful.xcolor0,
                        shape = helpers.rrect(beautiful.border_radius - 3),
                        widget = wibox.container.background
                    },
                    top = dpi(6),
                    left = dpi(5),
                    bottom = dpi(6),
                    right = dpi(5),
                    widget = wibox.container.margin
                },
                {
                    awful.widget.only_on_screen(final_systray, screen[1]),
                    top = dpi(6),
                    left = dpi(5),
                    bottom = dpi(6),
                    right = dpi(5),
                    widget = wibox.container.margin
                },
                {
                    {
                        {
                            s.mylayoutbox,
                            top = dpi(4),
                            bottom = dpi(4),
                            right = dpi(7),
                            left = dpi(7),
                            widget = wibox.container.margin
                        },
                        bg = beautiful.xcolor0,
                        shape = helpers.rrect(beautiful.border_radius - 3),
                        widget = wibox.container.background
                    },
                    top = dpi(6),
                    bottom = dpi(6),
                    left = dpi(5),
                    right = dpi(10),
                    widget = wibox.container.margin
                },

                layout = wibox.layout.fixed.horizontal
            }
        },
        {
            widget = wibox.container.background,
            bg = beautiful.widget_border_color,
            forced_height = beautiful.widget_border_width
        }

    }
end)

-- EOF ------------------------------------------------------------------------
