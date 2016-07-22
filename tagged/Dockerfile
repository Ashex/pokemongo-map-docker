# Basic docker image for PokemonGo-Map
# Usage:
#   docker build -t pokemongo-map .
#   docker run -d -P --name pokemongo-map pokemongo-map -a ptc -u UserName -p Password -l "Seattle, WA" -st 10 --google-maps-key CHECKTHEWIKI
FROM gliderlabs/alpine:3.4

MAINTAINER Ahmed Osman (/u/Ashex)

# default port the app runs on
EXPOSE 5000

# ca-certificates is needed because without it, pip fails to install packages due to a certificate failure
# plus it's needed to communicate with niantic servers because SSL
# build-base contains gcc, which is needed during the installation of the pycryptodomex pip package
RUN apk --no-cache add ca-certificates python python-dev py-pip build-base nodejs

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/

RUN pip install --no-cache-dir -r requirements.txt

COPY package.json /usr/src/app/

RUN npm install -g grunt \
    && npm install \
    && grunt jshint sass cssmin uglify \
    && npm remove -g grunt \
    && npm cache clean \
    && rm -rf node_modules \
    && rm -rf /tmp/* \

# Keeping this separate because docker cache might get weird with cleanup happening in the same RUN command
RUN apk del build-base python-dev py-pip

COPY . /usr/src/app

ENTRYPOINT ["/usr/bin/python", "runserver.py"]
