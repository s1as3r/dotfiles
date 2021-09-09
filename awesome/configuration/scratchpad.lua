local awful = require("awful")
local bling = require("module.bling")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local rubato = require("module.rubato")

local function check_if_alive(cmd)
    awful.spawn.easy_async_with_shell("pgrep -u $USER -x " .. cmd,
                                      function(stdout, stderr, reason, exit_code)
        if exit_code == 1 then awful.spawn(cmd) end
    end)
end

local anim_y = {
    y = rubato.timed {
        pos = 1090,
        rate = 120,
        easing = rubato.quadratic,
        intro = 0.1,
        duration = 0.3,
        awestore_compat = true
    }
}


local notion_scratch = bling.module.scratchpad:new{
    command = "notion-app",
    rule = {class = "Notion"},
    sticky = false,
    autoclose = false,
    floating = true,
    geometry = {x = dpi(460), y = dpi(90), height = dpi(800), width = dpi(1000)},
    reapply = true,
    -- dont_focus_before_close = false,
    rubato = anim_y
}

awesome.connect_signal("scratch::notion",
                       function() notion_scratch:toggle() end)


local discord_scratch = bling.module.scratchpad:new{
    command = "google-chrome-stable --new-window https://discord.com/app --new-instance --class=Discord",
    rule = {class = "Discord"},
    sticky = false,
    autoclose = false,
    floating = true,
    geometry = {x = dpi(460), y = dpi(90), height = dpi(800), width = dpi(1000)},
    reapply = true,
    -- dont_focus_before_close = false,
    rubato = anim_y
}

awesome.connect_signal("scratch::discord",
                       function() discord_scratch:toggle() end)

