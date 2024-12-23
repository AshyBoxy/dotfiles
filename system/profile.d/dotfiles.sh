# /etc/profile.d/dotfiles
# Set our umask
umask 022

EDITOR=nano
export EDITOR

# Source xdg bash profile, when interactive but not posix or sh mode
if test "$BASH" &&\
   test "$PS1" &&\
   test -z "$POSIXLY_CORRECT" &&\
   test "${0#-}" != sh
then
   XDG_BASHRC_LOC=${XDG_CONFIG_HOME:-"$HOME/.config"}
   [ -r "${XDG_BASHRC_LOC}/bash/bash_profile" ] && . "${XDG_BASHRC_LOC}/bash/bash_profile"
fi
