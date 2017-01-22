#!/bin/sh

LC_NUMERIC="en_US.UTF-8"

# battery percentages
FULL0=$(cat /sys/class/power_supply/BAT0/energy_full)
NOW0=$(cat /sys/class/power_supply/BAT0/energy_now)
FULL1=$(cat /sys/class/power_supply/BAT1/energy_full)
NOW1=$(cat /sys/class/power_supply/BAT1/energy_now)
LVL0=$(echo $NOW0/$FULL0\*100 | bc -l )
LVL1=$(echo $NOW1/$FULL1\*100 | bc -l )
printf 'BAT0/1: %.0f%%/%.0f%%' $LVL0 $LVL1

# get power consumption nW
W0=$(cat /sys/class/power_supply/BAT0/power_now)
W1=$(cat /sys/class/power_supply/BAT1/power_now)
# combine power now nW
WC=$(echo "$W0+$W1" | bc)

# get energy now nWh
WH0=$(cat /sys/class/power_supply/BAT0/energy_now)
WH1=$(cat /sys/class/power_supply/BAT1/energy_now)
# combine energy now nWh
WHC=$(echo "$WH0+$WH1" | bc)

# calc ETA
RI=$(echo "$WHC/$WC" | bc)
RF=$(echo "$WHC/$WC" | bc -l)

H=$RI
M=$(echo "($RF-$RI)*60" | bc)

printf ' (%i:%02.0f)' $H $M

