# Basic docker image for PokemonGo-Map
# Usage:
#   docker build -t pokemongo-map .
#   docker run -d -P --name pokemongo-map pokemongo-map -a ptc -u UserName -p Password -l "Seattle, WA" -st 5
FROM gliderlabs/alpine:3.4

MAINTAINER Ahmed Osman (/u/Ashex)

RUN apk add --update ca-certificates
RUN apk add \
    python \
    python-dev \
    py-pip \
    build-base \
    git \
    nodejs \
  && rm -rf /var/cache/apk/* \
  && npm install -g grunt

RUN pip install --no-cache-dir Flask==0.11.1 \
    Jinja2==2.8 \
    MarkupSafe==0.23 \
    Werkzeug==0.11.10 \
    argparse==1.2.1 \
    click==6.6 \
    itsdangerous==0.24 \
    peewee==2.8.1 \
    wsgiref==0.1.2 \
    geopy==1.11.0 \
    protobuf==2.6.1 \
    requests==2.10.0 \
    s2sphere==0.2.4 \
    gpsoauth==0.3.0 \
    protobuf-to-dict==0.1.0 \
    flask-cors==2.1.2 \
    PyMySQL==0.7.5

WORKDIR /app


EXPOSE 5000
COPY entrypoint.sh .

ENTRYPOINT ["/bin/sh", "entrypoint.sh"]