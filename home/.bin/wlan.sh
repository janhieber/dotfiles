#!/bin/sh

LC_NUMERIC="en_US.UTF-8"

if [ "$(iw dev wlp3s0 link)" = "Not connected." ]
then
    echo -n "down"
else
    SPEED=$(iw dev wlp3s0 link | grep "tx bitrate" | cut -d' ' -f3,4)
    SSID=$(iw dev wlp3s0 link | grep "SSID" | cut -d' ' -f2)
    echo -n $SSID
    echo -n "@"
    echo -n $SPEED
fi
