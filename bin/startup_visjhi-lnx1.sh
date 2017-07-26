#!/bin/sh

xsetroot -solid black

#vmware-user-suid-wrapper &
VBoxClient-all
dunst &

profile-cleaner f &

