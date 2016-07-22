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
  && rm -rf /var/cache/apk/*

RUN pip install Flask==0.11.1 \
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
    protobuf-to-dict==0.1.0

WORKDIR /app

# Pre-install most of the nodejs modules to speed up launch
# sass modules failed mysteriously so they must be installed at runtime
RUN npm install -g grunt \
    && npm install grunt@^0.4.5 \
    && npm install minimatch@0.2.14 \
    && npm install minimatch@0.3.0 \
    && npm install graceful-fs@1.2.3 \
    && npm install minimatch@2.0.10 \
    && npm install jshint@2.9.2 \
    && npm install node-gyp@3.4.0 \
    && npm install grunt-contrib-clean@latest \
    && npm install grunt-contrib-concat@latest \
    && npm install grunt-contrib-connect@latest \
    && npm install grunt-contrib-copy@latest \
    && npm install grunt-contrib-cssmin@latest \
    && npm install grunt-contrib-jshint@latest \
    && npm install grunt-contrib-uglify@latest \
    && npm install grunt-contrib-watch@latest \
    && npm install grunt-html-validation@^0.1.18 \
    && npm install grunt-include-file@^0.1.1 \
    && npm install grunt-legacssy@latest \
    && npm install grunt-unused@latest \
    && npm install grunt-usemin@latest \
    && npm install jshint-stylish@latest \
    && npm cache clean
  


EXPOSE 5000
COPY entrypoint.sh .

ENTRYPOINT ["/bin/sh", "entrypoint.sh"]