#!/bin/sh

CUR=$(cat /sys/class/backlight/intel_backlight/brightness)
MAX=$(cat /sys/class/backlight/intel_backlight/max_brightness)

STEP=6 # percent
STEP_=$(echo "$MAX/$STEP" | bc)

case $1 in
  'up')
    VAL=$[$CUR+$STEP_] 
    if [ $VAL -gt $MAX ]; then
      echo $MAX > /sys/class/backlight/intel_backlight/brightness
    else
      echo $VAL > /sys/class/backlight/intel_backlight/brightness
    fi
    ;;
  'down')
    VAL=$[$CUR-$STEP_] 
    if [ $VAL -lt 0 ]; then
      echo 0 > /sys/class/backlight/intel_backlight/brightness
    else 
      echo $VAL > /sys/class/backlight/intel_backlight/brightness
    fi
    ;;
  *)
    exit 1
    ;;
esac

