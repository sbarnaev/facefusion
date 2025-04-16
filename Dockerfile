# Используем официальный образ Python
FROM python:3.10-slim

# Устанавливаем системные зависимости
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libgl1 \
    && rm -rf /var/lib/apt/lists/*

# Копируем только необходимое (оптимизация сборки)
COPY requirements.txt .
COPY facefusion.py .

# Устанавливаем Python-зависимости с фиксированными версиями
RUN pip install --no-cache-dir -r requirements.txt \
    gradio==3.50.0 \
    fastapi==0.95.2 \
    uvicorn==0.22.0

# Запускаем через uvicorn с автоматическим перезапуском при ошибках
CMD ["uvicorn", "facefusion:app", "--host", "0.0.0.0", "--port", "8100", "--reload"]
