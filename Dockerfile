FROM python:3.10-slim
WORKDIR /app
COPY . .
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libgl1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir -r requirements.txt
CMD ["python", "facefusion.py", "run", "--execution-providers", "cpu"]
