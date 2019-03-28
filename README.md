# StackStorm's st2chatops

This repository delivers [StackStorm Chatops](https://docs.stackstorm.com/chatops) in a form of packages and docker image. The package includes [hubot](https://hubot.github.com/), [hubot-stackstorm](https://github.com/StackStorm/hubot-stackstorm)
and pre-installed adapters for many Chat services.

## Package

### Usage

For instructions to install st2chatops package from repos, please refer to StackStorm installation instruction for [Deb-based](https://docs.stackstorm.com/install/deb.html#setup-chatops) or [RPM-based](https://docs.stackstorm.com/install/rhel7.html#setup-chatops) distributions.

Make sure you've added StackStorm repos before installing the package.

### Node Version

Refer to official node [documentation](https://nodejs.org/en/download/package-manager/) on installing NodeJS from packages.

### Building

Building of the packages is handled automatically by CircleCI. In case you'd like to run it locally, you can use our building pipeline by running docker-compose:

        docker-compose run ${DISTRO} build

Where ${DISTRO} refers to flavor name. See [docker-compose.yml](docker-compose.yml) file for the list of supported flavors.

## Docker

### Usage

* Pull the StackStorm/hubot image:

        docker pull stackstorm/hubot

* Set a hostname or IP address that will be accessible form a docker container,
  as $ST2_HOSTNAME environment variable:

       export $ST2_HOSTNAME={MY_STACKSTORM_HOST_NAME}

* Use [`st2chatops.env`](st2chatops.env) to store the settings. The example uses Slack; set appropriate environment variables for other Chat Services:
[Slack](https://github.com/slackhq/hubot-slack),
[HipChat](https://github.com/hipchat/hubot-hipchat),
[Cisco Spark](https://github.com/tonybaloney/hubot-spark),
[Flowdock](https://github.com/flowdock/hubot-flowdock),
[IRC](https://github.com/nandub/hubot-irc),
[XMPP](https://github.com/markstory/hubot-xmpp),
[RocketChat](https://www.github.com/RocketChat/hubot-rocketchat),
[Mattermost](https://github.com/loafoe/hubot-matteruser).


* Use [scripts/st2chatops-docker-run.sh](scripts/st2chatops-docker-run.sh) to start the docker container instance.
The script is set for Slack; for other Chats, **edit it** to pass the environment variables as required for your Chat service adapter.
Run the script, and ensure that hubot-stackstorm is running and there are no errors:

        ./st2chatops-docker-run.sh
        docker inspect -f {{.State.Status}} stackstorm-hubot
        docker logs stackstorm-hubot

  To automatically start `stackstorm-hubot`, use [restart policies](https://docs.docker.com/engine/reference/run/#restart-policies-restart>),
  or [integrate with a process manager](https://docs.docker.com/engine/admin/host_integration).

* Go to your Chat room and begin Chatopsing. Learn more at [docs.stackstorm.com/chatops](https://docs.stackstorm.com/chatops)

### Node Version

Grab your favorite Node.JS version (>=8.0, <11.x), and pick your tag. Update `Dockerfile` as needed.

### Pre-Requsites

* Docker
* Docker Hub Login (only if you're pushing a new version to Docker Hub)

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

### Updating

* `hubot-slack` is not compatible with coffeescript 2 ([issue](https://github.com/slackapi/hubot-slack/issues/526), [PR](https://github.com/slackapi/hubot-slack/pull/528)) yet, so keep the `coffee-script` dependency pinned to `1.12.7`
* `coffee-register` is required for dynamic `require`, but it cannot be updated past `1.0.0` because more recent versions (eg: `2.0.0`+) require coffeescript version `2.0.0`+
