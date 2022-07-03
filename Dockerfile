FROM python:3.9-alpine3.13
LABEL maintainer="eddyirwan@gmail.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
COPY ./app /app

WORKDIR /app
EXPOSE 8000

# run 4 command seperated by && \
RUN python -m venv /py && \
	/py/bin/pip install --upgrade pip && \
	apk add --update --no-cache postgresql-client && \
	apk add --update --no-cache --virtual .tmp-deps \
		build-base postgresql-dev musl-dev && \
	/py/bin/pip install -r /requirements.txt && \
	apk del .tmp-deps && \
	adduser --disabled-password --no-create-home app && \
	mkdir -p /vol/web/static && \
	mkdir -p /vol/web/media && \
	chown -R app:app /vol && \
	chown -R 755 /vol


# put python virtual env in PATH
ENV PATH="/py/bin:$PATH"


# switch user from root to app

USER app

# docker-compose run --rm app sh -c "django-admin startproject app ."

# eddycute/password

