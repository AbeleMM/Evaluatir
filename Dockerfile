FROM python:3-slim

WORKDIR /usr/src/app

COPY requirements.txt requirements_prod.txt ./
RUN mkdir -p /usr/share/man/man1 \
  # ^ JDK Requirement
  && apt-get update \
  && apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  # ^ django-heroku (PostgreSQL) Requirement
  default-jdk \
  nodejs \
  && pip install --no-cache-dir -r requirements.txt -r requirements_prod.txt \
  && rm -rf /var/lib/apt/lists/*

COPY . .