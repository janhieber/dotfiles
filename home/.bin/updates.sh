#!/bin/sh

UAUR=$(cower -u | wc -l)
UPAC=$(checkupdates | wc -l)

echo "   PAC: ${UPAC} AUR: ${UAUR} "

