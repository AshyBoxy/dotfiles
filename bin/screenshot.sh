#!/usr/bin/env bash
BASE_FILENAME="/home/ashyboxy/hdd/screenshots/$(date '+%Y-%m-%d-%H%M%S')"

if [ "$XDG_SESSION_TYPE" = wayland ] ; then
    if [ "$XDG_SESSION_DESKTOP" = Hyprland ] && command -v hyprshot > /dev/null ; then
        FILENAME="${BASE_FILENAME}_hyprshot.png"
        hyprshot $@ -s -o "$(dirname "${FILENAME}")" -f "$(basename "${FILENAME}")"
    else
        FILENAME="${BASE_FILENAME}_grimshot.png"
        grimshot save $@ "${FILENAME}"
    fi
else
    FILENAME="${BASE_FILENAME}_scrot.png"
    scrot $@ "${FILENAME}"
fi

printf "${FILENAME}"
