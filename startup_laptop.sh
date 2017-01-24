#!/bin/sh

autorandr -c --default default &
xrdb -load .Xresources &
numlockx on &
nitrogen --restore &
xset r rate 250 45 &
nm-applet --sm-disable &
nextcloud &
dunst &
compton --backend glx --paint-on-overlay --vsync opengl-swc &
urxvtd &

