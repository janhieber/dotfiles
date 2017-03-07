#!/bin/sh

vmware-user-suid-wrapper &
dunst &

profile-cleaner f &

~/bin/polybar_$(hostname).sh

