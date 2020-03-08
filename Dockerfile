FROM python:3.7-alpine

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# use testing repo for hdf5
RUN echo "http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.8/main" >> /etc/apk/repositories; \
    echo "http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/v3.8/community" >> /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories; \
    echo "http://mirror1.hs-esslingen.de/pub/Mirrors/alpine/edge/testing" >> /etc/apk/repositories
# development dependencies
RUN apk update && apk add python3-dev libgcc libstdc++ gcc musl-dev postgresql-dev netcat-openbsd py-pip git

# image dependencies
RUN apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev g++

RUN apk add --no-cache --virtual sklearn-runtime python3 git bash zlib hdf5 libgfortran libgcc libstdc++ musl openblas && \
    apk add --no-cache --virtual .build-deps build-base python3-dev zlib-dev hdf5-dev freetype-dev libpng-dev openblas-dev && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    apk del .build-deps && \
    rm -rf /var/cache/apk/*
# RUN apk add --no-cache g++ && \
#     ln -s /usr/include/locale.h /usr/include/xlocale.h

# update pip and install pipenv
RUN pip install -U pip
RUN pip install pipenv

# setup path for codebase
RUN mkdir -p /code
WORKDIR /code

ADD . /code

# EXPOSE 8000
#RUN pipenv install -e git+https://github.com/facebookresearch/fastText.git#egg=fasttext
RUN pipenv install --dev

# ENTRYPOINT ["/start.sh"]

# code is linked in /code via volume
