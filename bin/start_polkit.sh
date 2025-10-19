#!/bin/sh
if  pgrep -x hyprpolkitagena ; then
    echo hyprpolkitagent already loaded
else
    echo starting hyprpolkitagent
    exec /usr/lib/hyprpolkitagent/hyprpolkitagent
fi
