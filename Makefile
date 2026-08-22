.PHONY: all build clean distclean watch

MAIN := main.tex

all:
	latexmk -pdf $(MAIN)

build: all

watch:
	latexmk -pdf -pvc $(MAIN)

clean:
	latexmk -c $(MAIN)

distclean:
	latexmk -C $(MAIN)
	rm -rf build
