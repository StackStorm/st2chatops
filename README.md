# hubot

This repository contains the out-of-the-box default settings for Hubot to be used inside a docker container.

Contains many pre-installed libraries for different adapters without waiting for NPM

## Usage

At a minimum, the following variables must be set:

* HUBOT_NAME: What is your bot name?
* HUBOT_ADAPTER: Chat Adapter used with Hubot
* HUBOT_ALIAS: Alias to be used with your bot.

Otherwise, set ENV variables as necessary for your adapter of choice.

## Node Version

Grab your favorite Node.JS version from https://hub.docker.com/_/node/, and pick your tag. Update `Dockerfile`
as needed.

### Pre-Requsites

* Docker
* Docker Hub Login (corporate login is in LastPass... create or attach your user to the `StackStorm` org)

### Building

* Step 0: Log in to docker with `docker login`.
  * Only have to do this the first time
* Step 1: Build the image: `docker build -t stackstorm/hubot:<VER> .`
  * Replace `<VER>` with a version tag
* Step 2: Push the container up: `docker push stackstorm/hubot:<VER>`
  * Use the same tag specified in Step 1.
* Step 3: Update the `latest` tag:
  ```
  docker build -t stackstorm/hubot:latest .
  docker push stackstorm/hubot:latest
  ```
* Step 4: Profit
