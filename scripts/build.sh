#!/bin/sh -e

if ! command -v mdbook > /dev/null 2>&1; then
  echo >&2 "mdbook is required for building the docs"
  echo >&2 'hint: try `cargo install mdbook --vers "^0.1.0"`'
  exit 1
fi

# Start in the repo directory.
cd $(dirname "$0")"/.."

# Build the individual books.
(cd home && mdbook build)
(cd guides/python && mdbook build)
(cd guides/image-rec && mdbook build)

# Move everything into a master book directory.
mkdir -p book
[ -z "$(ls -A book)" ] || rm -r book/*
cp -a home/book/. book/
rm -r book/guides
mkdir book/guides
cp -R guides/python/book book/guides/python
cp -R guides/image-rec/book book/guides/image-rec

touch book/.nojekyll
cp CNAME LICENSE book/
