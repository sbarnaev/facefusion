FROM python:3.10-slim

WORKDIR /app

# Установка системных зависимостей
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

# Копируем только нужные файлы (оптимизация размера образа)
COPY requirements.txt .
COPY facefusion.py .

# Установка Python-зависимостей
RUN pip install --no-cache-dir -r requirements.txt

# Основная команда (для CPU)
CMD ["python", "facefusion.py", "run", "--execution-providers", "cpu"]
