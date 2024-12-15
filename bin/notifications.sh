#!/usr/bin/env bash
if [ -z "$DOTFILES" ] ; then
    echo "DOTFILES is not set" >&2
    exit 1
fi

source "${DOTFILES}/config"

if [ -z "$notification_daemon" ] ; then
    echo "notification_daemon is not set" >&2
    exit 1
fi

if [ -z "$1" ] ; then
    echo "need an argument, duh" >&2
    exit 1
fi

case "$notification_daemon" in
    swaync)
        case "$1" in
            history) swaync-client -t ;;
            *) echo "unknown action $1 for $notification_daemon" 2>&2 ;;
        esac
        ;;
    dunst)
        case "$1" in
            history) dunstctl history-pop ;;
            *) echo "unknown action $1 for $notification_daemon" 2>&2 ;;
        esac
        ;;
    *) echo "unknown notification daemon \"$notification_daemon\"" >&2 ;;
esac
