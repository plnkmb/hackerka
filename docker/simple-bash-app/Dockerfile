FROM alpine:3.20

RUN apk add --no-cache bash pwgen coreutils

WORKDIR /opt/app

COPY start.sh /opt/app/start.sh
COPY config.template /opt/app/config.template

RUN chmod +x /opt/app/start.sh && mkdir -p /opt/app/data

VOLUME ["/opt/app/data"]

CMD ["/opt/app/start.sh"]