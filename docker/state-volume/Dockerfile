FROM debian:12-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends pwgen \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/app

COPY app/start.sh /opt/app/start.sh
COPY app/state.template /opt/app/state.template
COPY app/steps.list /opt/app/steps.list

RUN mkdir -p /opt/app/data && chmod +x /opt/app/start.sh

CMD ["/opt/app/start.sh"]
