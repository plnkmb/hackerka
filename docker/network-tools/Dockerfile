FROM alpine:latest

RUN apk add --no-cache \
    curl \
    iproute2 \
    iputils \
    bind-tools \
    python3

WORKDIR /app

RUN echo "network-tools container is working" > index.html

CMD ["python3", "-m", "http.server", "8000"]