hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
    vrr = 0
})
hl.monitor({
    output = "DVI-D-1",
    mode = "preferred",
    position = "0x0",
    scale = 1,
    vrr = 0
})
hl.monitor({
    output = "eDP-1",
    mode = "preferred",
    position = "0x0",
    scale = 1.25,
    bitdepth = 10,
    vrr = 1
})
-- monitor=eDP-1,1920x1200@60,auto,1,bitdepth,10,vrr,1
-- monitor=eDP-1,preferred,auto,1,bitdepth,10,vrr,1
-- monitor=eDP-1,preferred,auto,1,bitdepth,10,vrr,1,transform,1
-- monitor=DP-1,preferred,0x0,1
-- monitor=desc:Dell Inc. DELL U2412M YPPY08521ASL,preferred,-1920x0,1
-- monitor=DVI-D-1,preferred,0x0,1,vrr,0
-- monitor=desc:AOC 2475W MDMK91A000237,modeline 138.50 1920 1968 2000 2080 1080 1083 1088 1111 -hsync +vsync,auto,1
-- monitor=desc:AOC 2475W MDMK91A000237,1280x1280@75,auto,1

-- monitor=HDMI-A-1,preferred,1920x-360,1,transform,1
--  this crashes??
--  note: hyprland does NOT like extra spaces in the modeline
-- monitor=HDMI-A-1,modeline 110.50  1920 2016 2208 2496  1080 1083 1088 1108 -hsync +vsync,auto,1
--  headless outputs are currently broken :<
-- monitor=VIRT-0,1920x1080@60,0x1200,1
hl.monitor({
    output = "VIRT-LP",
    mode = "2240x1400@60",
    position = "auto",
    scale = 1.25
})

-- bindl=,switch:on:Lid Switch,exec,hyprctl keyword monitor "eDP-1,disable"
-- bindl=,switch:off:Lid Switch,exec,hyprctl keyword monitor "eDP-1,preferred,auto,1.25,bitdepth,10,vrr,1"
