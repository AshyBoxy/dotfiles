#!/bin/sh
# this could use mouse move instead, the choice is arbitrary
current_state=$( hyprctl -j getoption misc:key_press_enables_dpms | jq .int )

if [ "$current_state" = "0" ] ; then
    new_state=1
    new_state_text=on
else
    new_state=0
    new_state_text=off
fi

hyprctl keyword misc:key_press_enables_dpms $new_state
hyprctl keyword misc:mouse_move_enables_dpms $new_state

hyprctl notify 1 3000 0 "auto dpms wake turned $new_state_text"
