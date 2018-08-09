MD  := $(shell command -v $(or $(MDBOOK),mdbook) 2>/dev/null)
OUT := $(abspath $(or $(DEST),book))

# TESTS = rust python

GUIDES := $(wildcard guides/*)
DESIGNS := $(wildcard design/*)

SUB_BOOKS := $(addsuffix .guide,$(notdir $(GUIDES))) $(addsuffix .design,$(notdir $(DESIGNS)))

.PHONY: all
all: book

.PHONY: dependencies
dependencies:
ifndef MD
	$(info hint: try `cargo install mdbook --vers "^0.1.0"`)
	$(error mdbook is required for building the docs)
endif

%.guide: dependencies
	@$(MD) build guides/$(basename $@) --dest-dir $(OUT)/guides/$(basename $@)
	@mkdir -p home/src/guides/$(basename $@) && touch home/src/guides/$(basename $@)/index.html

%.design: dependencies
	@$(MD) build design/$(basename $@) --dest-dir $(OUT)/design/$(basename $@)
	@mkdir -p home/src/design/$(basename $@) && touch home/src/design/$(basename $@)/index.html

.PHONY: sub-books
sub-books: $(SUB_BOOKS)

.PHONY: book
book: sub-books
	@$(MD) build home --dest-dir $(OUT)

.PHONY: serve
serve: dependencies sub-books # sub-books to satisfy SUMMARY.md
	-@$(MD) serve home --dest-dir $(OUT)
	-@$(foreach book,$(GUIDES),$(MD) watch $(book) --dest-dir $(OUT)/guides/$(notdir $(book)) &)
	-@$(foreach book,$(DESIGNS),$(MD) watch $(book) --dest-dir $(OUT)/design/$(notdir $(book)) &)

.PHONY: stop
stop: dependencies
	pkill $(notdir $(MD))

.PHONY: clean
clean: dependencies
	-@$(MD) clean home --dest-dir $(OUT) 2>/dev/null
	@rm -rf home/src/guides
	@rm -rf home/src/design-docs
