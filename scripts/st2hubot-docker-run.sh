#!/bin/bash
# st2hubot-docker-run.sh - Conviniense script for running stackstorm-hubot docker container

HERE=$(dirname $(dirname "$(readlink -f "$0")"))

ST2_CONTAINER=stackstorm-hubot

if [[ ! -z $(docker ps -a | grep $ST2_CONTAINER) ]];
then
	echo "Terminating a previously running $ST2_CONTAINER instance..."
  /usr/bin/docker rm --force $ST2_CONTAINER
fi

# Launch with env variables
echo "Running $ST2_CONTAINER ..."
/usr/bin/docker run                                              \
  --name $ST2_CONTAINER --net bridge --detach=true               \
  -m 0b -p 8081:8080 --add-host $ST2_HOSTNAME:10.0.1.100         \
  -v $HERE/st2hubot.env:/app/st2hubot.env                        \
  stackstorm/hubot
