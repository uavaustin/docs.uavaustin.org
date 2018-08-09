MD  := $(shell command -v $(or $(MDBOOK),mdbook) 2>/dev/null)
OUT := $(abspath $(or $(DEST),book))

$(info $(OUT))

GUIDES := $(wildcard guides/*)
DESIGNS := $(wildcard design/*)

.PHONY: all
all: book

.PHONY: dependencies
dependencies:
ifndef MD
	$(info hint: try `cargo install mdbook --vers "^0.2.0"`)
	$(error mdbook is required for building the docs)
endif

.PHONY: stubs
stubs:
	@$(foreach book,$(GUIDES)$(DESIGN),mkdir -p home/src/$(book) && touch home/src/$(book)/index.html;)

guides/%: dependencies
	@$(MD) test $@ --dest-dir $(OUT)/$@
	@$(MD) build $@ --dest-dir $(OUT)/$@

design/%: dependencies
	@$(MD) test $@ --dest-dir $(OUT)/$@
	@$(MD) build $@ --dest-dir $(OUT)/$@

.PHONY: sub-books
sub-books: $(GUIDES) $(DESIGNS)

.PHONY: home
home: stubs
	$(MD) build home --dest-dir $(OUT)

.PHONY: book
book: home | sub-books

.PHONY: start
start: dependencies stubs # sub-books to satisfy SUMMARY.md
	-@$(MD) serve home --dest-dir $(OUT) &
	-@$(foreach book,$(GUIDES),$(MD) watch $(book) --dest-dir $(OUT)/guides/$(notdir $(book)) &)
	-@$(foreach book,$(DESIGNS),$(MD) watch $(book) --dest-dir $(OUT)/design/$(notdir $(book)) &)
	$(MAKE) sub-books

.PHONY: stop
stop: dependencies
	pkill $(notdir $(MD))

.PHONY: up
serve: start
	@read -p "Press enter to kill.." _
	-$(MAKE) stop

.PHONY: clean
clean: dependencies
	-@$(MD) clean home --dest-dir $(OUT) 2>/dev/null
	@rm -rf home/src/guides
	@rm -rf home/src/design-docs
