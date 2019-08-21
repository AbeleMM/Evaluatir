FROM python:3-slim

WORKDIR /usr/src/app

COPY . .
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
  && python manage.py collectstatic --noinput \
  && python manage.py migrate \
  && rm -rf /var/lib/apt/lists/*