#!/bin/sh -e

if [ ! command -v mdbook > /dev/null 2>&1 ]; then
  echo >&2 "mdbook is required for building the docs"
  exit 1
fi

# Start in the repo directory.
cd $(dirname "$0")"/.."

# Build the individual books.
(cd homepage && mdbook build)
(cd guides/python && mdbook build)

# Move everything into a master book directory.
cp -R homepage/book book
rm -r book/guides
mkdir book/guides
cp -R guides/python/book book/guides/python

touch book/.nojekyll
cp CNAME LICENSE book/
