#!/bin/sh

killall -q polybar                                                               
while pgrep -x polybar >/dev/null; do sleep 0.5; done                            
                                                                                 
MONITOR=eDP-1 polybar main &                                                
MONITOR=HDMI-1 polybar main &

