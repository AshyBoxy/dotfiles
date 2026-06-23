local exec = hl.exec_cmd

hl.on("hyprland.start", function()
    exec("eww daemon")
    exec("swaync")
    exec("waybar")
    exec("hyprpaper")
    exec("start_polkit.sh")
end)

hl.on("config.reloaded", function()
    exec("import-gsettings.sh")
    exec("hyprpm reload -n")
end)
