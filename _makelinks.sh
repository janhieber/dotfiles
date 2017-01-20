#!/bin/sh

# This script finds all files in the dotfiles/home dir.
# It creates/refreshes the symlinks to ~/ and handles
# cases where the file alreasy exists in your ~/

REPO=$(dirname `which $0`)

cd ~

LIST=$(find $REPO/home -type f | grep -v '/.git/')
readarray -t FILES <<<"$LIST"

for F in ${FILES[@]}
do
  F=${F#$(pwd)'/'}
  FO=${F#'dotfiles/home/'}
  
  if [ -h $FO ]; then
    # is symlink
    rm -f $FO
  else
    if [ -a $FO ]; then
      # regular file, backup
      echo -e "\n'$FO' exists and is no link."
      T1=$(stat -c '%Y' $FO)
      T2=$(stat -c '%Y' $F)
      if [ $T1 -gt $T2 ]; then
        echo -e "Your file is newer than repo file."
      else
        echo -e "Repo file is newer than yours."
      fi
      echo -e "  [b]ackup and link repo file"
      echo -e "  [c]opy to repo and link back"
      echo -e "  [s]kip"
      echo -ne "  choice: "
      read -n1 CHOICE
      echo ""
      case $CHOICE in
        b)
          echo -n "BAK  "
          mv -v $FO $FO.bak
          [ $? -ne 0 ] && echo "ERROR failed to backup: $FO" >&2
          echo ""
          ;;
        c)
          echo -n "RM   "
          rm -v $F
          echo -n "CP   "
          mv -v $FO $F
          echo ""
          ;;
        *)
          echo -e "SKIP $FO\n"
          continue
      esac
    fi
  fi

  # only link if file does not exist
  mkdir -p $(dirname $FO)
  if [ -a $FO ]; then
    echo "ERROR linking, $F0 already exists!"
  else
    echo -n "LINK "
    ln -sv $(pwd)/$F $(pwd)/$FO
  fi
done

