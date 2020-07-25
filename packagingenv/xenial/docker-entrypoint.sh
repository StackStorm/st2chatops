#!/bin/bash

operation="${1:-build}"

case "$operation" in
pull)
  ;;
build)
  # Updates the changelog by running:
  #
  #     debchange -v $(PKG_VERSION)-$(PKG_RELEASE) -M ""
  make changelog
  # Runs the sign hook
  # -b  - binary-only package
  # -uc - don't sign the .changes file
  # -us - don't sign the .dsc file
  dpkg-buildpackage -b -uc -us
  cp ../*.{deb,changes} $ARTIFACT_DIR
  ;;
*)
  [[ $# -gt 0 ]] && exec "$@"
  ;;
esac
