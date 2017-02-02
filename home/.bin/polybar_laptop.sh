#!/bin/sh

# kill all bars
killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 0.5; done

CFG="$HOME/.config/polybar/config_$(hostname)"

# launch a polybar first eDP-1 to get tray
MONITOR='eDP-1' polybar -q -c $CFG main &

# get connected displays and launch a bar for each
polybar -m | cut -d' ' -f1 | sed 's/://' |\
while read line; do
  [ "$line" != "eDP-1" ] && \
    MONITOR="$line" polybar -q -c $CFG main &
done

feh --no-fehbg --bg-tile ~/dotfiles/bg.png

