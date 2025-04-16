FROM python:3.10-slim

WORKDIR /app

# Установка системных зависимостей
RUN apt-get update && apt-get install -y \
    curl \  # ← Добавьте эту строку
    ffmpeg \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "facefusion.py", "run", "--execution-providers", "cpu"]
