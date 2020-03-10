FROM python:3.7-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

EXPOSE 8000

RUN apk update && apk add python3-dev libgcc libstdc++ gcc musl-dev postgresql-dev netcat-openbsd py-pip git

# image dependencies
RUN apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev g++

# update pip and install pipenv
RUN pip install -U pip
RUN pip install pipenv

# setup path for codebase
RUN mkdir -p /code
WORKDIR /code

ADD . /code

ENTRYPOINT [ "./docker/local/django/start.sh" ]
