hl.workspace_rule({
    workspace = "w[tv1]s[false]",
    gaps_in = 0,
    gaps_out = 0
})
hl.workspace_rule({
    workspace = "f[1]s[false]",
    gaps_in = 0,
    gaps_out = 0
})
hl.window_rule({
    name = "no-border-when-only",
    match = {
        workspace = "w[v1]s[false]"
    },
    border_size = 0,
    rounding = 0,
    no_shadow = true
})
hl.window_rule({
    name = "no-border-when-only",
    match = {
        workspace = "f[1]s[false]"
    },
    border_size = 0,
    rounding = 0,
    no_shadow = true
})

-- # make xdg file picker float and not be a horrible shape
-- # this also acts weirdly with hyprland's borders, for xwayland pickers, so just turn borders off
-- ##windowrule = float, size 1000 600,                      class:^[Xx]dg-desktop-portal-gtk$,initialTitle:^Open Files$
-- #windowrule = noborder on, norounding on, noshadow on,   class:^[Xx]dg-desktop-portal-gtk$,initialTitle:^Open Files$
-- # firefox's download thingy
-- # and possibly other popup windows
-- ##windowrule = float,                     class:^firefox$,initialTitle:^$
-- ##windowrule = center 1, size 454 174,    class:^firefox$,initialTitle:^$,title:^Opening

-- #layerrule = blur,^(swaync-control-center)$
