#!/bin/bash

# If no operation is given run complete suite (default behaviour)
operation="${1:-complete}"

case "$operation" in
pull)
  ;;
build)
  rpmbuild -bb rpm/st2hubot.spec
  cp ../*.rpm $ARTIFACT_DIR
  ;;
test)
  echo test
  ;;
complete)
  echo complete
  ;;
*)
  [ $# -gt 0 ] && exec "$@"
  ;;
esac
