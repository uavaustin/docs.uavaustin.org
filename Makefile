MD := $(shell command -v $(or $(MDBOOK),mdbook) 2>/dev/null)

.PHONY: all
all: book

.PHONY: dependencies
dependencies:
ifndef MD
	$(info hint: try `cargo install mdbook --vers "^0.1.0"`)
	$(error mdbook is required for building the docs)
endif

.PHONY: book
book: dependencies
	./scripts/build.sh

.PHONY: serve
serve: dependencies
	./scripts/serve.sh
