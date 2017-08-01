#!/bin/sh

java -Djava.awt.headless=true -jar $JDOWNLOADER_HOME/JDownloader.jar &

while true; do
  sleep 8
done
