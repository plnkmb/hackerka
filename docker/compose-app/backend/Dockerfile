FROM python:3.12-alpine

WORKDIR /app

COPY app.py /app/app.py

EXPOSE 8000

# При старте контейнера запускает Python-файл, который поднимает backend-сервер
CMD ["python3", "app.py"]