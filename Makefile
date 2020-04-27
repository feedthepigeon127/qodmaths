#suffix=$(or $(job),)

tex_files=$(filter-out preamble.tex,$(wildcard *.tex))
png_files=$(patsubst %.tex,%.png,$(tex_files))

all:

%.png %_ans.png: %.tex
	pdflatex -interaction=nonstopmode -jobname=$(basename $@) $< > /dev/null
	-asy -q $(basename $@)-*.asy > /dev/null 2>&1 && pdflatex -interaction=nonstopmode -jobname=$(basename $@) $< > /dev/null || true
	@rm -f $(basename $@)-*.asy $(basename $@)-*.tex
	convert -background white -density 300 $(basename $@).pdf -quality 90 $(basename $@).png
	@$(MAKE) -f $(lastword $(MAKEFILE_LIST)) --silent clean

.PHONY: clean
clean:
	@rm -f *.aux *.log *.lof *.bak *.loa *.log *.lot *.bbl
	@rm -f *.blg *.dvi *.out *.brf *.thm *.toc *.idx *.ilg *.ind
	@rm -f *.nav *.snm *.vrb *.lol *.tmp *.synctex *.synctex.gz
	@rm -f *.xwm *.pdf
	@rm -f *.pre *.cut
	@rm -f $(wildcard *-[0-9].asy) $(wildcard *-[0-9][0-9].asy)
	@rm -f $(wildcard *-[0-9].tex) $(wildcard *-[0-9][0-9].tex)
