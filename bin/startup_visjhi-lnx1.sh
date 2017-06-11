#!/bin/sh

xsetroot -bg #000000

vmware-user-suid-wrapper &
dunst &

profile-cleaner f &

