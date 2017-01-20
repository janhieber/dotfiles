#!/bin/sh

xrdb -load .Xresources &
xset r rate 250 45 &
urxvtd &
vmware-user-suid-wrapper &
