hl.config({
    debug = {
        -- disable_logs = false,
        -- enable_stdout_logs = true,
        error_position = 0,
        error_limit = 3
    },

    cursor = {
        use_cpu_buffer = 2,
        no_hardware_cursors = 1
    },

    render = {
        direct_scanout = 2
    },

    input = {
        kb_layout = "gb",
        kb_variant = "",
        kb_model = "",
        kb_options = "compose:rctrl, lv3:ralt_switch, lv5:caps_switch, shift:both_capslock, ashyboxy:scrolllock",
--        kb_options = "kb_options = compose:rctrl, lv3:ralt_switch, lv5:caps_switch, ashyboxy:scrolllock",
        kb_rules = "",

        repeat_rate = 30,
        repeat_delay = 350,

        follow_mouse = 1,

        touchpad = {
            natural_scroll = false
        },

        tablet = {
            output = "DVI-D-1"
        },

        sensitivity = 0
    },

    general = {
        gaps_in = 5,
        gaps_out = 5,
        border_size = 2,
        col = {
            -- active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            active_border = { colors = { "rgba(ffc6ffee)", "rgba(bdb2ffee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)"
        },

        layout = "hy3",
        allow_tearing = true
    },

    xwayland = {
        force_zero_scaling = true
    },

    decoration = {
        rounding = 5,

        blur = {
            enabled = true,
            size = 5,
            passes = 1
        },

        shadow = {
            enabled = true,
            range = 7,
            render_power = 3,
            color = "rgba(1a1a1aee)"
        }
    },

    misc = {
        -- vfr = false,
        -- vrr = false,
        -- force_default_wallpaper = 2,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,

        disable_hyprland_logo = true,
        disable_splash_rendering = true,

        enable_anr_dialog = false,
        disable_watchdog_warning = true
    },

    dwindle = {
        preserve_split = true
    },
    master = {
        new_status = "master"
    }
})


hl.config({
    animations = {
        enabled = true
    }
})

hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("workspaceFade", { type = "bezier", points = { { 0.05, 0.5 }, { 0.5, 0.05 } } })
hl.curve("easeOutCubic", { type = "bezier", points = { { 0.33, 1 }, { 0.68, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "fadeDpms", enabled = false })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "easeOutCubic", style = "fade" })
