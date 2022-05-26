#!/bin/sh

mode="c"
sleep_pid=0

refresh () {
    [ "$sleep_pid" -ne 0 ] &&
    kill $sleep_pid >/dev/null 2>&1
}

show_date () {
    date +"${1}: %a %b %d %H:%M"
}

trap "mode='p' && refresh" USR1
trap "mode='c' && refresh" USR2
#trap "mode='e' && refresh" INT
trap "mode='i' && refresh" INT

while true ; do
    case "$mode" in
        "e") TZ="Europe/Amsterdam" show_date Europe      ;;
        "c") TZ="America/Chicago"  show_date Central     ;;
        "i") TZ="Asia/Kolkata"     show_date India       ;;
        "p"|*) TZ="Asia/Manila"    show_date Philippines ;;
    esac
    sleep .5 &
    sleep_pid=$!
    wait
done
