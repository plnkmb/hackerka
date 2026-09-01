FROM python:3.12-alpine

WORKDIR /app

COPY index.html /app/index.html

EXPOSE 3000

CMD ["python3", "-m", "http.server", "3000"]