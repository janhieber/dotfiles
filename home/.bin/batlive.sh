#!/bin/sh

set -e

LC_NUMERIC="en_US.UTF-8"

# byttery full / current levels
FULL0=$(cat /sys/class/power_supply/BAT0/energy_full)
NOW0=$(cat /sys/class/power_supply/BAT0/energy_now)
FULL1=$(cat /sys/class/power_supply/BAT1/energy_full)
NOW1=$(cat /sys/class/power_supply/BAT1/energy_now)

# calc level in %
LVL0=$(echo $NOW0/$FULL0\*100 | bc -l )
LVL1=$(echo $NOW1/$FULL1\*100 | bc -l )
OUT=$(printf '%.0f%%/%.0f%%' $LVL0 $LVL1)

# current power
PWR0=$(cat /sys/class/power_supply/BAT0/power_now)
PWR1=$(cat /sys/class/power_supply/BAT1/power_now)
# combine power now
PWRNOW=$(echo "$PWR0+$PWR1" | bc)

# combined energy
WHC=$(echo "$NOW0+$NOW1" | bc)

# calc runtime
if [ $PWRNOW -gt 0 ]; then
  RI=$(echo "$WHC/$PWRNOW" | bc)
  RF=$(echo "$WHC/$PWRNOW" | bc -l)
  H=$RI
  M=$(echo "($RF-$RI)*60" | bc)
  OUT=$OUT$(printf ' (%i:%02.0f)' $H $M)
else
  OUT="$OUT CHR"
fi

echo $OUT

