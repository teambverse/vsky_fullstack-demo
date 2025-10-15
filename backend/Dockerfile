FROM python:3.10-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update \
    && apt-get install -y gcc default-libmysqlclient-dev libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .


RUN python manage.py migrate
RUN python manage.py collectstatic --noinput

EXPOSE 7001

# Run Gunicorn for production
CMD ["gunicorn", "mysite.wsgi:application", "--bind", "0.0.0.0:7001"]
