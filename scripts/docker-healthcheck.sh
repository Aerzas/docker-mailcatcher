#!/bin/sh
set -e

host=$(awk 'END{print $1}' /etc/hosts || echo '127.0.0.1')
status=$(wget --spider --server-response --quiet "http://${host}:1080" 2>&1 | awk '/^  HTTP/{print $2}')

if [ -n "${status}" ] && [ "${status}" = '200' ]; then
  exit 0
fi

exit 1
