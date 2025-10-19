#!/bin/sh
if  pgrep -x hyprpolkitagena ; then
    echo hyprpolkitagent already loaded
else
    echo starting hyprpolkitagent
    # it seems to die without having outputs attached?
    exec /usr/lib/hyprpolkitagent/hyprpolkitagent >/dev/null 2>/dev/null
fi
