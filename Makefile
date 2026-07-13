.PHONY: all clean distclean watch

MAIN := main.tex

all:
	latexmk -pdf $(MAIN)

watch:
	latexmk -pdf -pvc $(MAIN)

clean:
	latexmk -c $(MAIN)

distclean:
	latexmk -C $(MAIN)
	rm -rf build
