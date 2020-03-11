SRC := $(wildcard src/*.md)
IMG := $(wildcard img/*.png)
TARGET := $(addprefix docs/, $(addsuffix .html, $(basename $(notdir $(SRC)))))
IMGTARGET := $(addprefix docs/img/, $(notdir $(IMG)))

PFLAGS := --from=markdown+east_asian_line_breaks+emoji
PFLAGS += --to=html5
PFLAGS += --standalone
PFLAGS += --strip-comments
PFLAGS += --section-divs
PFLAGS += --filter pandoc-sidenote
#PFLAGS += --filter filters/RenderMath
PFLAGS += --template=tufte
PFLAGS += --css=./normalize.css
PFLAGS += --css=./tufte.min.css
PFLAGS += --css=./tufte-extra.css
PFLAGS += --css=./pandoc.css
#PFLAGS += --css=./katex.min.css
PFLAGS += --css=./custom.css
PFLAGS += --katex

CPFLAGS := -V include-after='<script src="https://utteranc.es/client.js" repo="mt-caret/nippo" issue-term="title" theme="github-light" crossorigin="anonymous" async></script>'

docs/img/%.png: img/%.png
	@mkdir -p docs/img
	@echo "$< -> $@"
	@optipng -o2 -clobber $< -out $@

docs/%.html: src/%.md filters/RenderMath
	@mkdir -p docs
	@echo "$< -> $@"
	@pandoc $(PFLAGS) $(CPFLAGS) -V include-after='$(shell ./navigation.sh $<)' $< --output=$@

docs/index.html: $(SRC)
	@mkdir -p docs
	@echo "./index.sh -> $@"
	@./index.sh | pandoc $(PFLAGS) --output=$@

.PRECIOUS: filters/%
filters/%: filters/%.hs
	stack --resolver lts-14.16 --install-ghc ghc --package pandoc-types --package text -- $< -o $@

.PHONY: clean
clean:
	rm -rf docs/*.html
	rm -rf docs/img/*.png

.PHONY: new
new:
	./new.sh

.PHONY: all
all: $(TARGET) $(IMGTARGET) docs/index.html

.PHONY: watch
watch: all
	@while sleep 1; do ls src/*.md | entr -cdrs "make all && serve ./docs/"; done
