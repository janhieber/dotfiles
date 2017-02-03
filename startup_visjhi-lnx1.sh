#!/bin/sh

xrdb -load .Xresources
xset r rate 250 45
urxvtd -f
vmware-user-suid-wrapper &

~/.bin/polybar_$(hostname).sh

