#!/bin/sh

function stopJDownloader {
  PID=$(cat $JDOWNLOADER_HOME/JDownloader.pid)
  kill $PID
  wait $PID
  exit
}

trap stopJDownloader EXIT

java -Djava.awt.headless=true -jar $JDOWNLOADER_HOME/JDownloader.jar &

while true; do
  sleep 8
done
