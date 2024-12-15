#!/usr/bin/bash
option=$1
before="$(hyprctl getoption "$option" | head -1 | sed 's/.* //')"
if [ "${before}" = "0" ]; then new=1
else new=0
fi
hyprctl keyword "$option" "$new"
