FROM ubuntu:22.04

WORKDIR /opt/support-app

COPY config.template /opt/support-app/config.template
COPY README.txt /opt/support-app/README.txt
COPY app.log /opt/support-app/logs/app.log

VOLUME ["/data", "/opt/support-app/logs"]

ENTRYPOINT ["sleep", "infinity"]