FROM openjdk:8-jre-alpine

MAINTAINER Alessandro Molari <molari.alessandro@gmail.com>
 
# == BASIC SOFTWARE ============================================================

RUN apk update \
 && apk upgrade

# == ENV / PARAMS ==============================================================

ENV JDOWNLOADER_USER jdownloader
ENV JDOWNLOADER_HOME /home/jdownloader

# == USER / GROUP ==============================================================

RUN adduser -D $JDOWNLOADER_USER -h $JDOWNLOADER_HOME -s /bin/bash

# == APP =======================================================================

ENV JDOWNLOADER_COMMAND java -Djava.awt.headless=true -jar -norestart $JDOWNLOADER_HOME/jdownloader.jar

# Install jdownloader.
RUN wget \
    --progress=bar:force \
    -O $JDOWNLOADER_HOME/jdownloader.jar \
    http://installer.jdownloader.org/JDownloader.jar

# Start jdownloader for the initial update and creation of config files.
RUN $JDOWNLOADER_COMMAND

# == LOGROTATE =================================================================

RUN apk add --update --no-cache logrotate

RUN mv /etc/periodic/daily/logrotate /etc/periodic/hourly/logrotate

ADD dist/logrotate.conf /etc/logrotate.d/nginx

# == RSYSLOG ===================================================================

RUN apk add --update --no-cache rsyslog

ADD dist/rsyslog.conf /etc/rsyslog.d/90-jdownloader.conf

# == SUPERVISORD ===============================================================

RUN apk add --update --no-cache supervisor

ADD dist/supervisord.ini /etc/supervisor.d/supervisord.ini

# == ENTRYPOINT ================================================================

EXPOSE 3389
EXPOSE 8080

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
