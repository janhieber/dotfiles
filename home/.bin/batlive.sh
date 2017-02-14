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
OUT=$(printf '%.0f%%/%.0f%%' $LVL0 $LVL1)

# current power
PWR0=$(cat /sys/class/power_supply/BAT0/power_now)
PWR1=$(cat /sys/class/power_supply/BAT1/power_now)
# combine power now
PWRNOW=$(echo "$PWR0+$PWR1" | bc)

# combined energy
WHC=$(echo "$NOW0+$NOW1" | bc)

# calc runtime
S0=$(cat /sys/class/power_supply/BAT0/status)
S1=$(cat /sys/class/power_supply/BAT1/status)
CHR=0
if [[ "$S0" = "Charging" || "$S1" = "Charging" ]]; then
  OUT="$OUT CHR"
  CHR=1
else
  if [[ $PWRNOW -gt 0 ]]; then
    RI=$(echo "$WHC/$PWRNOW" | bc)
    RF=$(echo "$WHC/$PWRNOW" | bc -l)
    H=$RI
    M=$(echo "($RF-$RI)*60" | bc)
    OUT=$OUT$(printf ' (%i:%02.0f)' $H $M)
  else
    OUT="$OUT CHR"
  fi
fi

echo $OUT

# check
if [[ $PWRNOW -gt 0 && $CHR -eq 0 ]]; then
  RF=$(echo "$WHC/$PWRNOW" | bc -l)
  
  # check low bat
  TMP=$(echo "$RF < 0.5" | bc -l)
  if [[ $TMP -eq 1 ]]; then
    # check flag, if already sent
    N=$(cat /run/batlive.state 2>/dev/null)
    if [[ $N -ne 1 ]]; then
      notify-send -u critical -a power "battery low!"
      echo 1 > /run/batlive.state
    fi
  fi
  
  # reset flag
  TMP=$(echo "$RF > 1.5" | bc -l)
  if [[ $TMP -eq 1 ]]; then
    N=$(cat /run/batlive.state 2>/dev/null)
    [[ $N -eq 1 ]] && echo 0 > /run/batlive.state
  fi

  # hibernate
  TMP=$(echo "$RF < 0.16" | bc -l)
  [[ $TMP -eq 1 ]] && systemctl hibernate 
fi



