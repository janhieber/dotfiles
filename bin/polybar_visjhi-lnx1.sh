#!/bin/sh

killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 0.5; done

MONITOR='Virtual1' polybar -c ~/.config/polybar/config_visjhi-lnx1 main &
MONITOR='Virtual2' polybar -c ~/.config/polybar/config_visjhi-lnx1 main &

