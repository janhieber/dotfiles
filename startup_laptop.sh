#!/bin/sh

# setup displays
autorandr -c --default default &

# do xorg stuff
xrdb -load .Xresources &
xset r rate 250 45
xrandr --newmode '1920x1080_60.00' 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync
xrandr --addmode DP-2 '1920x1080_60.00'
xrandr --newmode '1920x1200_60.00' 193.25 1920 2056 2256 2592 1200 1203 1209 1245 -hsync +vsync
xrandr --addmode DP-2 '1920x1200_60.00'
numlockx on &
compton -b

# launch some apps
nm-applet &
nextcloud &
dunst &
urxvtd -f

# set bg and launch bars
feh --no-fehbg --bg-tile ~/dotfiles/bg.png
~/.bin/polybar_$(hostname).sh
xeventbind resolution ~/.bin/polybar_$(hostname).sh &

