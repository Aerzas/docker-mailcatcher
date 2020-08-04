#!/bin/sh
set -e

build_version="${1}"

registry_image='aerzas/mailcatcher'

build_mailcatcher() {
  echo "$(printf '\033[32m')Build MailCatcher image$(printf '\033[m')"

  # Build image
  docker build \
    -t "${registry_image}:${build_version}" \
    -f Dockerfile \
    . \
    --no-cache

  # Push image
  docker push "${registry_image}:${build_version}"

  # Remove local image
  docker image rm "${registry_image}:${build_version}"
}

# Build MailCatcher
build_mailcatcher
