# /etc/profile sources /etc/bash.bashrc after all profile.d scripts, so this should run last

if [[ "$0" == /usr/share/sddm/scripts/* ]] ; then
    # just matching /etc/profile
    unset -v GLOBSORT

    . /etc/bash.bashrc
fi
