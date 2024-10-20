#!/usr/bin/env bash
if [ -z "$DOTFILES" ] ; then
    echo "DOTFILES is not set" >&2
    exit 1
fi

source "${DOTFILES}/config"

if [ -z "$screenshots_path" ] ; then
    echo "screenshots_path is not set" >&2
    exit 1
fi

BASE_FILENAME="${screenshots_path}/$(date '+%Y-%m-%d-%H%M%S')"

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
