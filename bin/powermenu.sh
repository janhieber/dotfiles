#!/bin/sh

res=$(echo "lock|suspend|suspend undock|hibernate|reboot|reboot to windows|shutdown|logout" | rofi -sep "|" -dmenu -i -p 'Power Menu: ' "" -auto-select)

function sure {
  local res=$(echo "no|yes" | rofi -sep "|" -dmenu -i -p "$1: sure?" -auto-select)
  [[ $res = "yes" ]] && exec $2
}

[[ $res = "suspend" ]]   && systemctl suspend
[[ $res = "suspend undock" ]]   && autorandr -l default && systemctl suspend
[[ $res = "lock" ]]      && ~/bin/i3lock-fancy.sh
[[ $res = "logout" ]]    && sure $res 'i3-msg exit'
[[ $res = "reboot" ]]    && sure $res 'systemctl reboot'
[[ $res = "reboot to windows" ]]    && sure "$res" 'sudo /usr/local/bin/reboot-windows'
[[ $res = "shutdown" ]]  && sure $res 'systemctl poweroff'
[[ $res = "hibernate" ]] && sure %res 'systemctl hibernate'

exit 0

