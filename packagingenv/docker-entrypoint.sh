#!/bin/bash

set -eu
set -o pipefail

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
*)
  [ $# -gt 0 ] && exec "$@"
  ;;
esac
