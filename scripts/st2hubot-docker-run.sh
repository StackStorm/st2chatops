#!/bin/bash
# st2hubot-docker-run.sh - Conviniense script for running stackstorm-hubot docker container

ST2_CONTAINER=stackstorm-hubot

if [[ ! -z $(docker ps -a | grep $ST2_CONTAINER) ]];
then
	echo "Terminating a previously running $ST2_CONTAINER instance..."
  /usr/bin/docker rm --force $ST2_CONTAINER
fi

# Export hubot-stackstorm settings
. st2hubot.env || exit 1;

# Launch with env variables
echo "Running $ST2_CONTAINER ..."
/usr/bin/docker run                                              \
  --name $ST2_CONTAINER --net bridge --detach=true               \
  -m 0b -p 8081:8080 --add-host $ST2_HOSTNAME:10.0.1.100         \
  -e ST2_WEBUI_URL=$ST2_WEBUI_URL                                \
  -e ST2_AUTH_URL=$ST2_AUTH_URL                              		 \
  -e ST2_API=$ST2_API_URL                                    		 \
  -e ST2_AUTH_USERNAME=$ST2_AUTH_USERNAME                   		 \
  -e ST2_AUTH_PASSWORD=$ST2_AUTH_PASSWORD                   		 \
  -e EXPRESS_PORT=$EXPRESS_PORT                             		 \
  -e NODE_TLS_REJECT_UNAUTHORIZED=$NODE_TLS_REJECT_UNAUTHORIZED  \
  -e HUBOT_ALIAS=$HUBOT_ALIAS                                    \
  -e HUBOT_LOG_LEVEL=$HUBOT_LOG_LEVEL                            \
  -e HUBOT_NAME=$HUBOT_NAME                                      \
  -e HUBOT_ADAPTER=$HUBOT_ADAPTER                                \
  -e HUBOT_SLACK_TOKEN=$HUBOT_SLACK_TOKEN                        \
  stackstorm/hubot