ae_neurocomp.pdf: ae_neurocomp.tex
	pdflatex ae_neurocomp.tex
	pdflatex ae_neurocomp.tex

clean:
	@echo "suppression des fichiers de compilation"
	@rm -f *.log *.aux *.dvi *.toc *.lot *.lof *.out *.nav *.snm *.blg *.bbl *.vrb

init: clean
	@echo "suppression des fichiers cibles"
	@rm -f *.pdf
