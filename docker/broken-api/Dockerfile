FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    python3 \
    curl \
    procps \
    iproute2 \
    less \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/sh app && \
    mkdir -p /srv/app/bin /srv/app/config /run/app

WORKDIR /srv/app

COPY app/api.py /srv/app/api.py
COPY bin/entrypoint.sh /srv/app/entrypoint.sh
COPY bin/run-api.sh /srv/app/bin/run-api.sh
COPY conf/runtime.env /run/app/runtime.env
COPY conf/banner.txt /srv/app/config/banner.txt

RUN chmod 0755 /srv/app/entrypoint.sh /srv/app/bin/run-api.sh && \
    chmod 0644 /srv/app/api.py && \
    chown root:root /srv/app/config/banner.txt && \
    chmod 0644 /srv/app/config/banner.txt

EXPOSE 8081

USER root

ENTRYPOINT ["/srv/app/entrypoint.sh"]