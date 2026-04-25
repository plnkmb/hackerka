FROM debian:12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    procps \
    coreutils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

CMD ["bash"]