#!/bin/sh -e

if [ ! command -v mdbook > /dev/null 2>&1 ]; then
  echo >&2 "mdbook is required for building the docs"
  exit 1
fi

# Start in the repo directory.
cd $(dirname "$0")"/.."

rm -rf book

# Build the individual books.
(cd homepage && mdbook build)

# Move everything into a master book directory.
cp -R homepage/book book

touch book/.nojekyll
cp CNAME LICENSE book/
