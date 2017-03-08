#!/bin/sh

xrdb -merge $HOME/.Xresources
xset s 3600 3600
xset r rate 250 45
numlockx on

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

exec i3

