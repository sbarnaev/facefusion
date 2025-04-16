FROM python:3.10-slim

WORKDIR /app

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

# Копируем ТОЛЬКО requirements.txt сначала (для кэширования)
COPY requirements.txt .

# Устанавливаем базовые зависимости с фиксированными версиями
RUN pip install --no-cache-dir \
    gradio==3.50.0 \
    fastapi==0.95.2 \
    uvicorn==0.22.0 \
    numpy==1.23.5 \
    onnxruntime==1.15.1

# Копируем остальные файлы
COPY . .

# Альтернативный запуск (если FastAPI не используется)
CMD ["python", "facefusion.py", "run", \
     "--execution-providers", "cpu", \
     "--host", "0.0.0.0", \
     "--port", "8100"]
