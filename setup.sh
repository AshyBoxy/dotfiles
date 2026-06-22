#!/usr/bin/env bash

# TODO: profile system

# these won't be set until the first log in after this script has put pam_env.conf in place
# defaults here should match the defaults in pam_env.conf
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

_find_dotfiles () {
    # this script probably won't be in a symlink ever
    local a="$(readlink "$1")"
    if [ -z "$a" ] ; then a="$1" ; fi
    a="$(readlink -f "$a")"
    if [ -a "${a}/is-dotfiles" ] ; then echo "$a" ; return 0 ; fi
    # skip the ~/.local/dotfiles fallback here
    return 1
}

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# specifically ignoring if $DOTFILES is already set
# this should always be absolute
# realistically it would work fine if it was relative, but it's easier to use absolute symlinks than calculate relative paths for everything
export DOTFILES="$(_find_dotfiles "$SCRIPT_DIR")"
if [ -z "$DOTFILES" ] ; then
    echo "could not find dotfiles directory?"
    exit 1
fi

# #region helpers

panic () {
    echo "panic: $1"
    exit 1
}

sep () {
    echo "====="
}

symlink () {
    local src="$1"
    local dst="$2"
    local required="$3"
    local ans

    if [ -L "$dst" ] ; then
        if [ "$(readlink -f "$dst")" = "$src" ] ; then
            return 0
        fi
    fi

    if [ -e "$dst" -a ! -L "$dst" ] ; then
        if [ "$required" = "y" ] ; then
            echo -n "$dst exists and is not a symlink. this is required, try to replace? (Y/n) "
        else
            echo -n "$dst exists and is not a symlink. try to replace? (y/N) "
        fi

        read ans
        if [ "$ans" != "y" ] ; then
            if [ "$required" = "y" ] ; then
                panic "could not replace $dst"
            fi
            echo "skipping $dst"
            return 1
        fi

        rm -rvf "$dst"

        if [ -e "$dst" ] ; then
            if [ "$required" = "y" ] ; then
                panic "failed to remove $dst"
            fi
            echo "failed to remove $dst"
            return 1
        fi
    fi
    ln -snfv "$src" "$dst"
}

ask () {
    local prompt="$1"
    local default="$2"
    local ans

    if [ "$default" = "r" ] ; then
        echo -n "$prompt (required) (y/n) "
    elif [ "$default" = "y" ] ; then
        echo -n "$prompt (Y/n) "
    else
        echo -n "$prompt (y/N) "
    fi

    read ans
    if [ "$default" = "r" ] ; then
        while [ "$ans" != "y" -a "$ans" != "n" ] ; do
            echo -n "$prompt (required) (y/n) "
            read ans
        done
    fi

    if [ -z "$ans" ] ; then
        ans="$default"
    fi
    if [ "$ans" != "y" -a "$ans" != "n" ] ; then
        panic "invalid answer"
    fi

    if [ "$ans" = "y" ] ; then
        return 0
    else
        if [ "$default" = "r" ] ; then
            panic "said no to something required"
        fi
        return 1
    fi
}

install_system () {
    # TODO: sudo alternatives
    local src="$1"
    local dst="$2"
    # r = required, s = skip asking (always yes)
    local t="$3"
    local owner="$4"
    if [ -z "$owner" ] ; then owner="root:root" ; fi

    if [ -e "$dst" ] ; then
        # skip if the files are the same
        if [ -f "$src" ] && [ -f "$dst" ] && cmp -s "$src" "$dst" ; then
            return 0
        fi

        if [ "$t" = "r" ] ; then ask "replace $dst with $src?" r
        elif [ "$t" = "s" ] ; then true
        elif ! ask "replace $dst with $src?" y ; then
            echo "skipping $dst"
            return 1
        fi
    fi

    [ -d "$dst" ] && echo "removing '$dst'" && sudo rm -rf "$dst"
    [ ! -d "$(dirname "$dst")" ] && sudo mkdir -vp "$(dirname "$dst")"

    echo "'$src' -> '$dst'"
    sudo cp -rf "$src" "$dst"

    sudo chown -R "$owner" "$dst"
}

systemd_user_enable_if_exists () {
    local service="$1"
    local status="$(systemctl --user is-enabled "$service" 2>/dev/null || true)"
    [ "$status" = "disabled" ] && systemctl --user enable "$service"
}

# #endregion helpers


### debug prints
echo "XDG_CONFIG_HOME=${XDG_CONFIG_HOME}"
echo "XDG_DATA_HOME=${XDG_DATA_HOME}"
echo "XDG_CACHE_HOME=${XDG_CACHE_HOME}"
echo "DOTFILES=${DOTFILES}"
sep


any_dirs_created=n
if [ ! -d "${XDG_CONFIG_HOME}" ] ; then
    mkdir -vp "${XDG_CONFIG_HOME}"
    any_dirs_created=y
fi
if [ ! -d "${XDG_DATA_HOME}" ] ; then
    mkdir -vp "${XDG_DATA_HOME}"
    any_dirs_created=y
fi
if [ ! -d "${XDG_CACHE_HOME}" ] ; then
    mkdir -vp "${XDG_CACHE_HOME}"
    any_dirs_created=y
fi
if [ "$any_dirs_created" = "y" ] ; then sep ; fi


### debug tests
if false ; then
    symlink "${DOTFILES}/_test" "${XDG_CONFIG_HOME}/_test"
fi


### system wide config
ask "install system wide config?" r

install_system "${DOTFILES}/system/bashrc" "/etc/bash.bashrc" r
for i in "${DOTFILES}/system/profile.d/"* ; do
    install_system "$i" "/etc/profile.d/$(basename "$i")" s
done

install_system "${DOTFILES}/system/pam_env.conf" "/etc/security/pam_env.conf" r

if ask "install system wide nanorc?" y ; then
    install_system "${DOTFILES}/system/nanorc" "/etc/nanorc" s
    install_system "${DOTFILES}/system/nanorc-custom" "/usr/share/nano/custom" s
fi

sep

### user config
symlink "${DOTFILES}/bash" "${XDG_CONFIG_HOME}/bash" y
home_bash_files=("${HOME}/.bashrc" "${HOME}/.bash_profile" "${HOME}/.bash_logout" "${HOME}/.bash_history")
home_bash_files_exist=n
for f in "${home_bash_files[@]}" ; do [ -e "$f" ] && home_bash_files_exist=y ; done
if [ "$home_bash_files_exist" = "y" ] && ask "remove existing bash files in home?" y ; then
    for f in "${home_bash_files[@]}" ; do rm -vf "$f" ; done
    echo "note: existing bash sessions might recreate .bash_history when exited, so you'll probably have to remove it again"
fi

symlink "${DOTFILES}/wayland/hypr" "${XDG_CONFIG_HOME}/hypr"
symlink "${DOTFILES}/wayland/waybar" "${XDG_CONFIG_HOME}/waybar"
symlink "${DOTFILES}/kitty" "${XDG_CONFIG_HOME}/kitty"

sep

### local setup
[ ! -e "${DOTFILES}/bash/bash_history" ] && echo "creating ${DOTFILES}/bash/bash_history" && touch "${DOTFILES}/bash/bash_history"

systemd_user_enable_if_exists pipewire.socket
systemd_user_enable_if_exists pipewire-pulse.socket
systemd_user_enable_if_exists wireplumber.service

sep

echo done
