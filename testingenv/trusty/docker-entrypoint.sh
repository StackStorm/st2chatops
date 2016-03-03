#!/bin/bash

operation="${1:-test}"

case "$operation" in
pull)
  ;;
test)
  dpkg -i $ARTIFACT_DIR/*.deb
  cd /opt/stackstorm/chatops
  sed -i.bak -r "s/^# (export HUBOT_ADAPTER=slack)/\1/" st2chatops.env
  sed -i.bak -r "s/^# (export HUBOT_SLACK_TOKEN.).*/\1$SLACK_TOKEN/" st2chatops.env
  sed -i.bak -r "s/^(export ST2_AUTH_USERNAME.).*/\1$ST2_USERNAME/" st2chatops.env
  sed -i.bak -r "s/^(export ST2_AUTH_PASSWORD.).*/\1$ST2_PASSWORD/" st2chatops.env
  bin/hubot &> /tmp/hubot.log &
  sleep 10
  cat /tmp/hubot.log
  grep -rq "INFO Slack client now connected" /tmp/hubot.log && \
  grep -rq "INFO [[:digit:]]\+ commands are loaded" /tmp/hubot.log
  exit $?
  ;;
*)
  [ $# -gt 0 ] && exec "$@"
  ;;
esac
