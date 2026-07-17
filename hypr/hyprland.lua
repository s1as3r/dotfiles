require("binds")

-- https://wiki.hyprland.org/Configuring/Basics/Monitors/
local moninfo = require("moninfo")
hl.monitor(moninfo.dell)
hl.monitor(moninfo.laptop)

local function disable_laptop_if_have_dell(timeout)
  return function()
    hl.timer(function()
      if hl.get_monitor(moninfo.dell.output) then
        hl.monitor({
          output = moninfo.laptop.output,
          disabled = true
        })
      end
      -- hl.notification.create({ text = "disbled boe", timeout = 3000, color = "#00FFFF" })
    end, { timeout = timeout, type = "oneshot" })
  end
end

hl.on("hyprland.start", disable_laptop_if_have_dell(500))
-- hl.on("config.reloaded", disable_laptop_if_have_dell(500))

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", 16)
hl.env("HYPRCURSOR_SIZE", 24)
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")

local autostart_cmds = {
  "hyprpaper", "waybar", "swaync-client df",
  "pypr", "warp-taskbar", "tailscale systray",
  "clipse -listen", "systemctl --user start hyprpolkitagent"
}
hl.on("hyprland.start", function()
  for _, cmd in ipairs(autostart_cmds) do
    hl.exec_cmd(cmd)
  end
end)

-- https://wiki.hyprland.org/Configuring/Basics/Variables/
hl.config({
  -- https://wiki.hypr.land/Configuring/Basics/Variables/--general
  general    = {
    gaps_in = 2,
    gaps_out = 10,

    border_size = 2,

    col = {
      active_border = { colors = { "#33ccffee", "#00ff99ee", angle = 45 } },
      inactive_border = "#595959aa"
    },

    resize_on_border = true,

    allow_tearing = false,

    layout = "dwindle"
  },

  -- https://wiki.hyprland.org/Configuring/Basics/Variables/--decoration
  decoration = {
    rounding = 10,
    rounding_power = 2,

    active_opacity = 1.0,
    inactive_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "#1a1a1aee",
    },

    -- https://wiki.hyprland.org/Configuring/Basics/Variables/--blur
    blur = {
      enabled = true,
      size = 3,
      passes = 1,

      vibrancy = 0.1696
    },
  },
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.config({
  animations = {
    enabled = true,
  },
})

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })


hl.config({
  -- https://wiki.hyprland.org/Configuring/Layouts/Dwindle-Layout/
  dwindle = {
    preserve_split = true,
  },

  -- https://wiki.hyprland.org/Configuring/Layouts/Master-Layout/
  master  = {
    new_status = "master"
  },
})

hl.config({
  -- https://wiki.hyprland.org/Configuring/Basics/Variables/#misc
  misc     = {
    force_default_wallpaper = -1,
    disable_hyprland_logo = false,
  },

  -- https://wiki.hyprland.org/Configuring/Basics/Variables/#xwayland
  xwayland = {
    -- force_zero_scaling = true
    use_nearest_neighbor = false,
  },
})

-- https://wiki.hyprland.org/Configuring/Basics/Variables/#input
hl.config({
  input = {
    kb_layout = "us",
    kb_options = "caps:backspace",
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = {
      natural_scroll = true,
    }
  }
})

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })

-- https://wiki.hyprland.org/Configuring/Basics/Window-Rules/
-- https://wiki.hyprland.org/Configuring/Basics/Workspace-Rules/
hl.window_rule({
  name = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule(
  {
    name = "fix-xwayland-drags",
    match = {
      class = "^$",
      title = "^$",
      xwayland = true,
      float = true,
      fullscreen = false,
      pin = false,
    },
    no_focus = true,
  }
)

hl.layer_rule({
  match = {
    namespace = "waybar"
  },
  blur = true,
  ignore_alpha = 0.5,
})

hl.layer_rule({
  match = {
    namespace = "swaync-control-center",
  },
  blur = true,
  ignore_alpha = 0.5,
})

hl.layer_rule({
  match = {
    namespace = "swaync-notification-window",
  },
  blur = true,
  ignore_alpha = 0.5,
})
