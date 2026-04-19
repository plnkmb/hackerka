FROM ubuntu:22.04

COPY conf/welcome.txt /welcome.txt

CMD ["bash", "-c", "cat /welcome.txt && tail -f /dev/null"]