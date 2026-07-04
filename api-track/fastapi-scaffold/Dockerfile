# Phase 1 "deploy it once" — a minimal container for the Findings API.
FROM python:3.12-slim

WORKDIR /srv

# Install deps first so the layer caches when only app code changes.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

EXPOSE 8000
# 0.0.0.0 so the port is reachable from outside the container.
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
