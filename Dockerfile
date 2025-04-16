FROM python:3.10-slim

WORKDIR /app

# Установка зависимостей
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

# Копируем ВЕСЬ проект
COPY . .

# Установка Python-пакетов
RUN pip install --no-cache-dir -r requirements.txt

# Запуск (версия 3.x)
CMD ["python", "-m", "facefusion", "run", "--execution-providers", "cpu"]
