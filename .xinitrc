#!/bin/sh

~/bin/lock.sh
sleep 0.5

xsetroot -cursor top_left_arrow
xsetroot -cursor_name left_ptr
xset s off -dpms
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

exec i3

