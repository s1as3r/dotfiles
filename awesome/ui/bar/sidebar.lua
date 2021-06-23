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
    widget = wibox.widget.textbox,
    font = beautiful.icon_font_name .. 15,
    markup = helpers.colorize_text("", beautiful.xcolor5)
}

local kb_icon = wibox.widget {
    {icon1, left = dpi(0), top = dpi(1), widget = wibox.container.margin},
    bg = beautiful.xcolor0,
    widget = wibox.container.background
}

kb_icon:buttons(gears.table.join(awful.button({}, 1, function()
    awesome.emit_signal("scratch::kb")
end)))

-- Tasklist Buttons -----------------------------------------------------------

---{{{ taglist buttons
local taglist_buttons = gears.table.join(
                            awful.button({}, 1, function(t) t:view_only() end),
                            awful.button({modkey}, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end), awful.button({}, 3, awful.tag.viewtoggle),
                            awful.button({modkey}, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end), awful.button({}, 4, function(t) awful.tag.viewprev(t.screen) end),
                            awful.button({}, 5, function(t)
        awful.tag.viewnext(t.screen)
    end))
---}}}

---{{{ tasklist buttons
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
---}}}

-- Create the Wibar -----------------------------------------------------------

local function format_entry(wid, inner_pad, outter_pad)
    return wibox.widget {
        {
            {
                wid,
                margins = dpi(inner_pad or 5),
                widget = wibox.container.margin
            },
            bg = beautiful.xcolor0,
            shape = helpers.rrect(beautiful.border_radius - 3),
            widget = wibox.container.background
        },
        margins = dpi(5),
        widget = wibox.container.margin
    }
end

local hourtextbox = wibox.widget.textclock("%H") -- old:  %a, %d %b %R
hourtextbox.markup = helpers.colorize_text(hourtextbox.text, beautiful.xcolor4)
hourtextbox.align = "center"
hourtextbox.valign = "center"

local minutetextbox = wibox.widget.textclock("%M") -- old:  %a, %d %b %R
minutetextbox.markup = helpers.colorize_text(minutetextbox.text,
                                             beautiful.xcolor4)
minutetextbox.align = "center"
minutetextbox.valign = "center"

hourtextbox:connect_signal("widget::redraw_needed", function()
    hourtextbox.markup = helpers.colorize_text(hourtextbox.text,
                                               beautiful.xcolor6)
end)

-- hourtextbox:emit_signal("widget::redraw_needed")
-- minutetextbox:emit_signal("widget::redraw_needed")

local clockbox = wibox.widget {
    {
        {hourtextbox, minutetextbox, layout = wibox.layout.fixed.vertical},
        top = 5,
        bottom = 5,
        widget = wibox.container.margin
    },
    bg = beautiful.xcolor0,
    widget = wibox.container.background
}

screen.connect_signal("request::desktop_decoration", function(s)
    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create layoutbox widget
    s.mylayoutbox = awful.widget.layoutbox(s)

    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "left",
        screen = s,
        type = "dock",
        width = dpi(40),
        height = s.geometry.height - 4 * beautiful.useless_gap,
        x = 0,
        y = 2 * beautiful.useless_gap,
        ontop = true,
        visible = true,
        shape = helpers.prrect(beautiful.border_radius, false, true, true, false),
        bg = beautiful.xbackground
    })

    --[[s.mywibox2 = wibox {
        width = dpi(40),
        height = s.geometry.height - 4 * beautiful.useless_gap,
        x = 0,
        y = 2 * beautiful.useless_gap,
        ontop = true,
        visible = true,
        shape = helpers.prrect(beautiful.border_radius, false, true, true, false),
        bg = beautiful.xbackground
    }]] --

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

    local ghost = gears.surface.load_uncached(
                      gfs.get_configuration_dir() .. "icons/ghosts/ghost.png")
    local ghost_icon = gears.color.recolor_image(ghost, beautiful.xcolor6)
    local dot = gears.surface.load_uncached(
                    gfs.get_configuration_dir() .. "icons/ghosts/dot.png")
    local dot_icon = gears.color.recolor_image(dot, beautiful.xcolor8)
    local pacman = gears.surface.load_uncached(
                       gfs.get_configuration_dir() .. "icons/ghosts/pacman.png")
    local pacman_icon = gears.color.recolor_image(pacman, beautiful.xcolor3)

    -- Function to update the tags
    local update_tags = function(self, c3)
        local imgbox = self:get_children_by_id('icon_role')[1]
        if c3.selected then
            imgbox.image = pacman_icon
        elseif #c3:clients() == 0 then
            imgbox.image = dot_icon
        else
            imgbox.image = ghost_icon
        end
    end

    -- Create a custom taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {shape = gears.shape.rectangle, font = statusbar_font},
        layout = {
            spacing = 0,
            spacing_widget = {
                shape = gears.shape.rectangle,
                widget = wibox.widget.separator
            },
            layout = wibox.layout.fixed.vertical
        },
        widget_template = {
            {
                {id = 'icon_role', widget = wibox.widget.imagebox},
                id = 'margin_role',
                top = dpi(6),
                bottom = dpi(6),
                left = dpi(4),
                right = dpi(4),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            create_callback = function(self, c3, index, objects)
                update_tags(self, c3)
                self:connect_signal('mouse::enter', function()
                    if #c3:clients() > 0 then
                        awesome.emit_signal("bling::tag_preview::update", c3)
                        awesome.emit_signal("bling::tag_preview::visibility", s,
                                            true)
                    end
                    if self.bg ~= beautiful.xbackground .. "60" then
                        self.backup = self.bg
                        self.has_backup = true
                    end
                    self.bg = beautiful.xbackground .. "60"
                end)
                self:connect_signal('mouse::leave', function()
                    awesome.emit_signal("bling::tag_preview::visibility", s,
                                        false)
                    if self.has_backup then
                        self.bg = self.backup
                    end
                end)
            end,
            update_callback = function(self, c3, index, objects)
                update_tags(self, c3)
            end
        },
        buttons = taglist_buttons
    }

    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        style = {shape = helpers.rrect(beautiful.border_radius)},
        layout = {
            spacing = 0,
            spacing_widget = {
                shape = gears.shape.rectangle,
                widget = wibox.widget.separator
            },
            layout = wibox.layout.fixed.vertical
        },
        widget_template = {
            {
                {
                    {
                        {
                            nil,
                            awful.widget.clienticon,
                            nil,
                            layout = wibox.layout.fixed.horizontal
                        },
                        margins = dpi(10),
                        widget = wibox.container.margin

                    },

                    id = "background_role",
                    shape = helpers.rrect(beautiful.border_radius - 3),
                    widget = wibox.container.background
                },
                left = dpi(5),
                right = dpi(5),
                top = dpi(5),
                bottom = dpi(5),
                widget = wibox.container.margin
            },
            visible = true,
            layout = wibox.layout.fixed.vertical
        },
        buttons = tasklist_buttons
    }

    local mysystray = wibox.widget.systray()
    mysystray:set_base_size(beautiful.systray_icon_size)
    mysystray:set_horizontal(false)
    mysystray:set_screen("primary")

    local mysystray_container = {
        mysystray,
        left = dpi(3),
        right = dpi(2),
        top = dpi(3),
        bottom = dpi(3),
        widget = wibox.container.margin
    }

    -- Add widgets to the wibox
    s.mywibox:setup{
        layout = wibox.layout.align.vertical,
        expand = "none",
        { -- Top widgets
            layout = wibox.layout.fixed.vertical,
            helpers.vertical_pad(6),
            format_entry(s.mytaglist)
            -- helpers.vertical_pad(8),
        },
        { -- Middle widgets
            s.mytasklist,
            layout = wibox.layout.fixed.vertical,
            nil
        },
        { -- Bottom widgets
            layout = wibox.layout.fixed.vertical,
            format_entry(kb_icon),
            format_entry(clockbox),
            format_entry(s.mylayoutbox),
            format_entry(mysystray_container),
            helpers.vertical_pad(6)
        }
    }

    s.mywibox.height = s.geometry.height - 4 * beautiful.useless_gap
    s.mywibox.y = 2 * beautiful.useless_gap
end)

-- EOF ------------------------------------------------------------------------
