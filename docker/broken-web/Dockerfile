FROM ubuntu:24.04

RUN apt-get update && apt-get install -y \
    python3 \
    curl \
    procps \
    iproute2 \
    less \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/sh app && \
    mkdir -p /opt/app/data /etc/app

WORKDIR /opt/app

COPY app/server.py /opt/app/server.py
COPY app/start.sh /opt/app/start.sh
COPY conf/app.env /etc/app/app.env
 ENV APP_ENV_FILE=/etc/app/app.env 
COPY conf/message.txt /opt/app/data/message.txt

RUN chmod 0755 /opt/app/start.sh && \
    chmod 0644 /opt/app/server.py && \
    chown app:app /opt/app/data/message.txt && \
    chmod 0644 /opt/app/data/message.txt

EXPOSE 8080

USER root

CMD ["/opt/app/start.sh"]