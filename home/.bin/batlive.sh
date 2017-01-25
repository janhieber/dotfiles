#!/bin/sh

LC_NUMERIC="en_US.UTF-8"

# byttery full / current levels
FULL0=$(cat /sys/class/power_supply/BAT0/energy_full)
NOW0=$(cat /sys/class/power_supply/BAT0/energy_now)
FULL1=$(cat /sys/class/power_supply/BAT1/energy_full)
NOW1=$(cat /sys/class/power_supply/BAT1/energy_now)

# calc level in %
LVL0=$(echo $NOW0/$FULL0\*100 | bc -l )
LVL1=$(echo $NOW1/$FULL1\*100 | bc -l )
OUT=$(printf 'BAT0/1: %.0f%%/%.0f%%' $LVL0 $LVL1)

# get current power consumption
W0=$(cat /sys/class/power_supply/BAT0/power_now)
W1=$(cat /sys/class/power_supply/BAT1/power_now)
# combine power now
WC=$(echo "$W0+$W1" | bc)

# combine energy now nWh
WHC=$(echo "$NOW0+$NOW1" | bc)

# calc runtime
RI=$(echo "$WHC/$WC" | bc)
RF=$(echo "$WHC/$WC" | bc -l)
H=$RI
M=$(echo "($RF-$RI)*60" | bc)

OUT=$OUT$(printf ' (%i:%02.0f)' $H $M)

echo $OUT
echo $OUT

if [ $(echo "$H<0.1" | bc) -eq 1 ] && [ $(echo "$M<15" | bc) -eq 1 ]; then
  echo "#FF7066"
  exit 33
fi
if [ $(echo "$H<0.1" | bc) -eq 1 ] && [ $(echo "$M<40" | bc) -eq 1 ]; then
  echo "#FFAF00"
fi

exit 0
