#!/bin/sh

autorandr -c --default default &
xrdb -load .Xresources &
numlockx on &
nitrogen --restore &
xset r rate 250 45
nm-applet &
nextcloud &
dunst &
compton -b
urxvtd -f

~/.bin/polybar_.sh

