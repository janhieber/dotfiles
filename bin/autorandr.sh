#!/bin/sh

export XAUTHORITY=/home/jan/.Xauthority
export DISPLAY=":0"
/usr/local/bin/autorandr -c -d default
/usr/bin/feh --no-fehbg --bg-tile ~/bg.jpg
