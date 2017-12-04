#!/bin/sh

[[ -x ~/bin/lock.sh ]] && ~/bin/lock.sh

# this is for QT icon theme
export DESKTOP_SESSION=gnome

xsetroot -cursor_name left_ptr
#xset s off -dpms
xset r rate 250 45
xrdb -merge $HOME/.Xresources
setxkbmap -option ctrl:nocaps
numlockx on

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# for Void Linux use consolekit
if [ -f /usr/bin/runit ]
then
    exec ck-launch-session i3
else
    exec i3
fi

