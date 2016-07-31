# Basic docker image for PokemonGo-Map
# Usage:
#   docker build -t pokemongo-map .
#   docker run -d -P --name pokemongo-map pokemongo-map -a ptc -u UserName -p Password -l "Seattle, WA" -st 10 --google-maps-key CHECKTHEWIKI
FROM python:2.7-alpine

MAINTAINER Ahmed Osman (/u/Ashex)

# default port the app runs on
EXPOSE 5000

# ca-certificates is needed because without it, pip fails to install packages due to a certificate failure
# plus it's needed to communicate with niantic servers because SSL
# build-base contains gcc, which is needed during the installation of the pycryptodomex pip package
RUN apk --no-cache add ca-certificates build-base nodejs sed

WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app/

RUN pip install --no-cache-dir -r requirements.txt

COPY package.json Gruntfile.js /usr/src/app/

COPY static /usr/src/app/static

RUN npm install -g grunt-cli \
    && npm install \
    && grunt sass cssmin uglify \
    && npm uninstall -g grunt-cli \
    && rm -rf node_modules 
 
RUN apk del build-base && rm -rf /tmp/*



COPY . /usr/src/app/


ENTRYPOINT ["/bin/sh", "entrypoint.sh"]
