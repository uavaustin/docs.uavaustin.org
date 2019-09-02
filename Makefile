MD  := $(shell command -v $(or $(MDBOOK),mdbook) 2>/dev/null)
OUT := $(abspath $(or $(DEST),book))

GUIDES := $(wildcard guides/*)
DESIGNS := $(wildcard design/*)

BOOKS := $(GUIDES) $(DESIGN)

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

$(BOOKS): dependencies
	@$(MD) test $@ --dest-dir $(OUT)/$@
	@$(MD) build $@ --dest-dir $(OUT)/$@
	@echo ".content img { max-width: 100%; display:block; margin: 0 auto; }" >> $(OUT)/$@/css/general.css

.PHONY: sub-books
sub-books: $(BOOKS)

.PHONY: home
home: dependencies stubs
	@$(MD) build home --dest-dir $(OUT)

.PHONY: book
book: home | sub-books

.PHONY: start
start: dependencies stubs
	-@$(MD) serve home --dest-dir $(OUT) &
	-@$(foreach book,$(GUIDES),$(MD) watch $(book) --dest-dir $(OUT)/guides/$(notdir $(book)) &)
	-@$(foreach book,$(DESIGNS),$(MD) watch $(book) --dest-dir $(OUT)/design/$(notdir $(book)) &)
	$(MAKE) sub-books

.PHONY: stop
stop: dependencies
	@pkill $(notdir $(MD))

.PHONY: serve-naive
serve-naive: start
	@read -p "Press enter to kill.." _
	-@$(MAKE) stop

.PHONY: serve
serve:
	-@bash -c "trap 'trap - SIGINT SIGQUIT ERR; echo \"Stopping server...\" && $(MAKE) stop >/dev/null 2>&1' SIGINT SIGQUIT ERR; $(MAKE) serve-naive"

.PHONY: serve-single
serve-single: dependencies
	-@bash -c "select book in $(GUIDES) $(DESIGNS); do $(MD) serve \$$book ; break; done"

.PHONY: clean
clean: dependencies
	-@$(MD) clean home --dest-dir $(OUT) 2>/dev/null
	@rm -rf home/src/guides
	@rm -rf home/src/design
