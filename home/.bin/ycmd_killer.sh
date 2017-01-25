#!/bin/sh

date >> /tmp/ycm.log

ps -o pid,ppid,cmd -C python | tr -s ' ' | sed 's/^ //' | cut -d' ' -f1,2,4 | grep '/ycmd/ycmd' | \
while read line; do
  IFS=' ' read PID_ PPID_ CMD_ ARG_ <<< $(echo $line)
  if [ $PPID_ -eq 1 ]; then
    kill -INT $PID_
  fi
done

