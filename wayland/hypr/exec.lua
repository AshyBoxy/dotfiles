local exec = hl.exec_cmd

local function execAlways()
    exec("import-gsettings.sh")
    exec("hyprpm reload -n")
end

hl.on("hyprland.start", function()
    exec("systemctl --user start hyprland-session.target")
    exec("eww daemon")
    exec("swaync")
    exec("waybar")
    exec("hyprpaper")
    exec("start_polkit.sh")
    execAlways()
end)

hl.on("config.reloaded", function()
    execAlways()
end)
