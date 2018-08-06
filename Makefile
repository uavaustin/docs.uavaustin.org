.PHONY: all
all: book

.PHONY: book
book:
	./scripts/build.sh

.PHONY: serve
serve:
	./scripts/serve.sh
