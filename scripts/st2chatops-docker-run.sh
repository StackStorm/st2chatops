#!/bin/bash
# st2chatops-docker-run.sh - Conviniense script for running stackstorm-hubot docker container

HERE=$(dirname $(dirname "$(readlink -f "$0")"))

ST2_CONTAINER=stackstorm-st2chatops

if [[ ! -z $(docker ps -a | grep $ST2_CONTAINER) ]];
then
	echo "Terminating a previously running $ST2_CONTAINER instance..."
  /usr/bin/docker rm --force $ST2_CONTAINER
fi

# Launch with env variables
echo "Using config: ${HERE}/st2chatops.env"
echo "Running $ST2_CONTAINER ..."

/usr/bin/docker run                                              \
  --name $ST2_CONTAINER --net bridge --detach=true               \
  -m 0b -p 8081:8080 --add-host $ST2_HOSTNAME:10.0.1.100         \
  -v $HERE/st2chatops.env:/app/st2chatops.env                    \
  stackstorm/st2chatops
