FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    pwgen \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/app

COPY app/ /opt/app/

RUN chmod +x /opt/app/start.sh

VOLUME ["/opt/app/data"]

CMD ["/opt/app/start.sh"]