#!/bin/sh

xsetroot -bg #000000

#vmware-user-suid-wrapper &
VBoxClient-all
dunst &

profile-cleaner f &

