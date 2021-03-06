FROM python:3.7-alpine

# set work directory
WORKDIR /app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DEBUG 0

# install python and update
RUN apk update \
    && apk add --virtual build-deps gcc python3-dev musl-dev \
    && apk del build-deps

# install dependencies
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy project
COPY . .

# collect static files
RUN python manage.py collectstatic --noinput

# add and run as non-root user
RUN adduser -D testuser
USER testuser

VOLUME /vol
RUN cd /vol


CMD gunicorn mysite.wsgi:application --bind 0.0.0.0:$PORT

