#!/bin/sh

STATE=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify \
  /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get \
  string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus' 2>/dev/null \
  | tail -n1 | grep -Po '".*?"' | sed 's/"//g')

if [[ "$STATE" = "Playing" ]]; then
  ARTIST=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify \
    /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get \
    string:'org.mpris.MediaPlayer2.Player' string:'Metadata' 2>/dev/null \
    | grep -A 2 'xesam:artist' | tail -n1 | grep -Po '".*?"' | sed 's/"//g')
  
  TITLE=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify \
    /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get \
    string:'org.mpris.MediaPlayer2.Player' string:'Metadata' 2>/dev/null \
    | grep -A 1 'title' | tail -n1 | grep -Po '".*?"' | sed 's/"//g')

  echo $ARTIST - $TITLE
else
  echo '-'
fi

