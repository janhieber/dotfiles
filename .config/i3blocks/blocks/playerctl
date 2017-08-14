#!/bin/sh

PLAYPAUSE="⏯"
PREVIOUS="⏪"
NEXT="⏩"

case ${BLOCK_INSTANCE} in
    play-pause)
        [[ ${BLOCK_BUTTON} -eq 1 ]] && playerctl play-pause
        TEXT=$PLAYPAUSE
        ;;
    next)
        [[ ${BLOCK_BUTTON} -eq 1 ]] && playerctl next
        TEXT=$NEXT
        ;;
    previous)
        [[ ${BLOCK_BUTTON} -eq 1 ]] && playerctl previous
        TEXT=$PREVIOUS
        ;;
esac

echo $TEXT
echo $TEXT

exit 0
