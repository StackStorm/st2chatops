FROM node:20.11.1-slim

RUN apt update && apt install --yes \
  python3 \
  npm \
  libicu-dev \
  libxml2-dev \
  libexpat1-dev \
  build-essential \
  git \
  make

COPY . /app
WORKDIR /app
RUN npm install npm@6 -g
RUN npm install --production && npm cache verify

RUN apt remove --yes \
  libicu-dev \
  libxml2-dev \
  libexpat1-dev \
  build-essential \
  git \
  make

RUN apt autoremove --yes

EXPOSE 8081
CMD ["source /app/st2chatops.env && /app/bin/hubot"]
