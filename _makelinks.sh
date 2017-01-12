#!/bin/sh

REPO=$(dirname `which $0`)

cd ~

LIST=$(find $REPO/home -type f | grep -v '/.git/')
readarray -t FILES <<<"$LIST"

for F in ${FILES[@]}
do
    F=${F#$(pwd)'/'}
    FO=${F#'dotfiles/home/'}
    
    if [ -h $FO ]
    then
        # is symlink
        rm -f $FO
    else
        if [ -a $FO ]
        then
            # regular file, backup
            mv -v $FO $FO.bak
            RES=$?
            [ $RES -ne 0 ] && echo failed to backup: $FO >&2
        fi
    fi
    
    mkdir -p $(dirname $FO)
    [ -a $FO ] || ln -sv $F $FO
done

