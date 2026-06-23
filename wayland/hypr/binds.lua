local hy3 = hl.plugin.hy3
local bind = hl.bind
local function binde(keys, dispatcher)
    bind(keys, dispatcher, { repeating = true })
end

-- TODO: hyprctl dispatch calls need to be updated to be lua

hl.config({
    binds = {
        workspace_back_and_forth = true
    }
})

bind(mainMod .. " + SHIFT + Q", hl.dsp.window.close())
bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
bind(mainMod .. " + SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
bind(mainMod .. " + CTRL + space", hl.dsp.window.alter_zorder({ mode = "top" }))
-- bind(mainMod .. " + D", hl.dsp.exec_cmd("wofi --show drun"))
bind(mainMod .. " + D", hl.dsp.exec_cmd("rofi -show drun"))
bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("rofi -show run"))

bind(mainMod .. " + V", hy3.make_group("v"))
bind(mainMod .. " + H", hy3.make_group("h"))
bind(mainMod .. " + E", hy3.change_group("opposite"))
bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
bind(mainMod .. " + G", hl.dsp.window.fullscreen({ mode = "maximized" }))


local function bindFocusMove(direction)
    bind(mainMod .. " + " .. direction, hy3.move_focus(direction))
    bind(mainMod .. " + SHIFT + " .. direction, hy3.move_window(direction))
end
bindFocusMove("left")
bindFocusMove("right")
bindFocusMove("up")
bindFocusMove("down")


bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    binde("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }))
    binde("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }))
    binde("up", hl.dsp.window.resize({ x = 0, y = -10, relative = true }))
    binde("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }))

    bind("escape", hl.dsp.submap("reset"))
    bind("return", hl.dsp.submap("reset"))
    bind(mainMod .. " + R", hl.dsp.submap("reset"))
end)


local function bindWorkspace(key, workspace)
    bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
end
for i = 1, 10 do
    bindWorkspace(i % 10, i)
end
bindWorkspace("minus", 11)
bindWorkspace("equal", 12)
bindWorkspace("KP_End", 13)
bindWorkspace("KP_Down", 14)
bindWorkspace("KP_Next", 15)
bindWorkspace("KP_Left", 16)
bindWorkspace("KP_Begin", 17)
bindWorkspace("KP_Right", 18)
bindWorkspace("KP_Home", 19)
bindWorkspace("KP_Up", 20)
bindWorkspace("KP_Prior", 21)
bindWorkspace("KP_Insert", 22)

bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

bind(mainMod .. " + CTRL + SHIFT + 1", hl.dsp.workspace.move({ monitor = "DP-1" }))
bind(mainMod .. " + CTRL + SHIFT + 2", hl.dsp.workspace.move({ monitor = "HDMI-A-1" }))
bind(mainMod .. " + CTRL + SHIFT + 3", hl.dsp.workspace.move({ monitor = "eDP-1" }))

bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("sleep 0.2 && hyprctl dispatch dpms toggle"))
bind(mainMod .. " + CTRL + P", hl.dsp.dpms({ action = "on" }))
bind(mainMod .. " + SHIFT + MOD3 + P", hl.dsp.exec_cmd("toggle-auto-dpms-wake.sh"))
bind(mainMod .. " + MOD3 + 1", hl.dsp.dpms({ monitor = "DVI-D-1" }))
-- specifically 2 doesn't seem to work?
bind(mainMod .. " + MOD3 + 3", hl.dsp.dpms({ monitor = "HDMI-A-1" }))

-- TODO: openrgb server
bind(mainMod .. " + MOD3 + F1", hl.dsp.exec_cmd("openrgb -p off"))
bind(mainMod .. " + MOD3 + F2", hl.dsp.exec_cmd("openrgb -p pink"))


bind(mainMod .. " + CTRL + space", hl.dsp.exec_cmd("dunstctl close"))
bind(mainMod .. " + CTRL + SHIFT + space", hl.dsp.exec_cmd("dunstctl close-all"))
bind(mainMod .. " + grave", hl.dsp.exec_cmd("notifications.sh history"))

bind(mainMod .. " + SHIFT + s", hl.dsp.exec_cmd("screenshot.sh -z -m region"))
bind(mainMod .. " + CTRL + s", hl.dsp.exec_cmd("screenshot.sh -z -m window"))
bind(mainMod .. " + SHIFT + CTRL + s", hl.dsp.exec_cmd("screenshot.sh -m window -m active"))
bind(mainMod .. " + MOD3 + s", hl.dsp.exec_cmd("screenshot.sh -m output -m active"))
-- bind(mainMod .. " + MOD3 + s", hl.dsp.exec_cmd("notify-send -a test summary 'body here'"))


bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"))
bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
bind(mainMod .. " + F10", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"))
bind(mainMod .. " + F9", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"))
bind("XF86AudioMicMute", hl.dsp.exec_cmd("pactl set-source-mute @DEFAULT_SOURCE@ toggle"))
bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
bind("MOD1 + CTRL + SHIFT + P", hl.dsp.exec_cmd("playerctl play-pause"))
bind("MOD1 + CTRL + SHIFT + Right", hl.dsp.exec_cmd("playerctl next"))
bind("MOD1 + CTRL + SHIFT + Left", hl.dsp.exec_cmd("playerctl previous"))


bind(mainMod .. " + SHIFT + semicolon", hl.dsp.submap("empty"))
hl.define_submap("empty", function()
    bind(mainMod .. " + SHIFT + semicolon", hl.dsp.submap("reset"))
end)



bind(mainMod .. " + SHIFT + CTRL + p", hl.dsp.exec_cmd("killall -SIGUSR2 waybar"))

-- bind(mainMod .. " + l", hl.dsp.exec_cmd("hyprlock"))

bind(mainMod .. " + SHIFT + CTRL + m", hl.dsp.exec_cmd("hyprpm reload -n"))
bind(mainMod .. " + SHIFT + CTRL + r", hl.dsp.exec_cmd("hyprctl reload"))

bind("SUPER + SHIFT + CTRL + f", hl.dsp.exec_cmd("toggle-hyprland-bool.sh input:follow_mouse"))
bind("SUPER + SHIFT + CTRL + m", hl.dsp.exec_cmd("toggle-hyprland-bool.sh input:touchpad:disable_while_typing"))

bind("SUPER + SHIFT + v", hl.dsp.exec_cmd("bash -c 'sleep 0.5; wtype -d 25 \"$(wl-paste)\"'"))
-- sometimes xwayland throws a fit
bind("MOD3 + v", hl.dsp.exec_cmd("bash -c 'xclip -o | wl-copy ; hyprctl notify 1 1500 0 \"copied x clipboard to wayland\"'"))
bind(mainMod .. " + p", hl.dsp.exec_cmd("hyprpicker -anl"))

bind(mainMod .. " + SHIFT + ALT + s", hl.dsp.exec_cmd("killall -9 hyprpicker"))
