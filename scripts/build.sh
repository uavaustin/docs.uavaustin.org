#!/bin/sh -e

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
