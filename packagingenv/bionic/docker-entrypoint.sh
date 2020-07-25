#!/bin/bash

operation="${1:-build}"

case "$operation" in
pull)
  ;;
build)
  make changelog
  dpkg-buildpackage -b -uc -us
  cp ../*.{deb,changes} $ARTIFACT_DIR
  ;;
/bin/bash)
  /bin/bash
  ;;
*)
  [[ $# -gt 0 ]] && exec "$@"
  ;;
esac
