-- https://wiki.hypr.land/Configuring/Basics/Binds/
local main_mod = "SUPER"

-- programs
local terminal = "kitty"
local file_manager = "nautilus"
local menu = { name = "wofi", cmd = "wofi -n" }
local browser = "firefox"

hl.bind(main_mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + e", hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. " + b", hl.dsp.exec_cmd(browser))
hl.bind(main_mod .. " + SPACE",
  hl.dsp.exec_cmd("pkill " .. menu.name .. " || " .. menu.cmd)
)

hl.bind(main_mod .. " + q", hl.dsp.window.close())
hl.bind(main_mod .. " + SHIFT + q", hl.dsp.exit())
hl.bind(main_mod .. " + t", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod .. " + p", hl.dsp.window.pseudo())
hl.bind(main_mod .. " + SHIFT + p", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(main_mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))

-- window focus
hl.bind(main_mod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(main_mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod .. " + j", hl.dsp.focus({ direction = "down" }))

-- moving windows
hl.bind("ALT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind("ALT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("ALT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind("ALT + down", hl.dsp.window.move({ direction = "down" }))

hl.bind("ALT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind("ALT + l", hl.dsp.window.move({ direction = "right" }))
hl.bind("ALT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind("ALT + j", hl.dsp.window.move({ direction = "down" }))

-- workspaces
for i = 1, 10 do
  local key = i % 10
  hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- scratchpad
hl.bind(main_mod .. " + s", hl.dsp.workspace.toggle_special("scratchpad"))
hl.bind(main_mod .. " + SHIFT + s", hl.dsp.window.move({ workspace = "special:scratchpad" }))

-- pyprland
hl.bind(main_mod .. " + CTRL + RETURN", hl.dsp.exec_cmd("pypr toggle term"))
hl.bind(main_mod .. " + CTRL + b", hl.dsp.exec_cmd("pypr toggle btop"))
hl.bind(main_mod .. " + v", hl.dsp.exec_cmd("pypr toggle clipse"))

-- screenshot
hl.bind(main_mod .. " + CTRL + PRINT", hl.dsp.exec_cmd("hyprshot -m window -o ~/Pictures/Screenshots/"))
hl.bind(main_mod .. " + ALT + PRINT", hl.dsp.exec_cmd("hyprshot -m output -o ~/Pictures/Screenshots/"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots/"))


-- scroll through existing workspaces with scroll
hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- move/resize windows with LMB/RMB and dragging
hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(main_mod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
  hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  hl.bind("up", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  hl.bind("down", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
  hl.bind("escape", hl.dsp.submap("reset"))
end)

-- laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
