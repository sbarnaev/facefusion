FROM python:3.10-slim

WORKDIR /app
RUN apt-get update && apt-get install -y \
    ffmpeg \
    libgl1

COPY . .
RUN pip install --no-cache-dir -r requirements.txt

CMD ["python", "facefusion.py", "--api"]
