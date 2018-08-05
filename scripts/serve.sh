#!/bin/sh -e

if [ ! command -v docker > /dev/null 2>&1 ]; then
  echo >&2 "docker is required for serving the docs"
  exit 1
fi

# Start in the repo directory.
cd $(dirname "$0")"/.."

echo "Hosting documentation at http://localhost:3000 with nginx."

docker run -it --rm -p 3000:80 -v "$(pwd)"/book:/usr/share/nginx/html:ro nginx
