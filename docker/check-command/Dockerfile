FROM ubuntu:22.04

RUN apt-get update && apt-get install -y less && rm -rf /var/lib/apt/lists/*

COPY conf/welcome.txt /welcome.txt

CMD ["bash", "-c", "cat /welcome.txt && tail -f /dev/null"]