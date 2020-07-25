#!/bin/bash

# If no operation is given run complete suite (default behaviour)
operation="${1:-complete}"

case "$operation" in
pull)
  ;;
build)
  npm install
  ;;
test)
  echo test
  ;;
complete)
  echo complete
  ;;
/bin/bash)
  /bin/bash
  ;;
*)
  [[ $# -gt 0 ]] && exec "$@"
  ;;
esac
