#!/bin/sh

case $1 in
  'up')
    pamixer -i 5
    ;;
  'down')
    pamixer -d 5
    ;;
  'toggle')
    pamixer -t
    ;;
  *)
    exit 1
esac

#notify-send "Audio $(pamixer --get-volume)%"

