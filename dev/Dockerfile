FROM node:20.11.1-slim

RUN apt-get update && apt-get install -y \
  python \
  libicu-dev \
  libxml2-dev \
  libexpat1-dev \
  build-essential \
  git \
  make

RUN mkdir /app

WORKDIR /app

EXPOSE 8081
VOLUME ["/app"]
CMD ["/app/dev/docker-entrypoint.sh"]
