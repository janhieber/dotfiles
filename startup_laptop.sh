#!/bin/sh

autorandr -c --default default &
xrdb -load .Xresources &
numlockx on &
nitrogen --restore &
xset r rate 250 45 &
nm-applet --sm-disable &
nextcloud &
xfce4-power-manager --sm-client-disable &
xfce4-volumed-pulse &
compton --backend glx --paint-on-overlay --vsync opengl-swc &
urxvtd &

