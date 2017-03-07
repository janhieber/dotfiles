#!/bin/sh

# You need a dir wit bare git repos.
# Clone them with: git clone --bare ...
# This script in cron fetches the repos

DIR="$HOME/gitbak"
LOG="$DIR/log.txt"

cd $DIR

echo "" >> $LOG
echo "START $(date --rfc-2822)" >> $LOG
echo "working in: $(pwd)" >> $LOG

for i in ./*.git
do
  echo "BACKUP $i" >> $LOG
  sh -c "cd $i && git fetch >> $LOG 2>&1"
done

echo "FINISH" >> $LOG

