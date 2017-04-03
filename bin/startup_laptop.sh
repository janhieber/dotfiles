#!/bin/sh

# setup displays
autorandr -c --default default &

# do xorg stuff
xrandr --newmode '1920x1080_60.00' 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync
xrandr --addmode DP-2 '1920x1080_60.00'
xrandr --newmode '1920x1200_60.00' 193.25 1920 2056 2256 2592 1200 1203 1209 1245 -hsync +vsync
xrandr --addmode DP-2 '1920x1200_60.00'
#xrandr --addmode DP-2-1 "1920x1080_60.00"
compton -b

# launch some apps
gnome-keyring-daemon --start --components=secrets -d --unlock
nm-applet &
nextcloud &
dunst &
#i3-msg 'workspace 9:Chat; exec qutebrowser --backend webengine -r chat'
profile-cleaner f &

# launch bars
~/bin/polybar_$(hostname).sh
xeventbind resolution ~/bin/polybar_$(hostname).sh &

