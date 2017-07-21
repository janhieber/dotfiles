#!/bin/sh

i3lock -c 000000 -e
sleep 0.5

xsetroot -cursor top_left_arrow
setxkbmap -option ctrl:nocaps
xrdb -merge $HOME/.Xresources
xset s off -dpms
xset r rate 250 45
numlockx on

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

exec i3

