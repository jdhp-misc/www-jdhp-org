brevets.pdf: brevets.tex
	pdflatex brevets.tex
	pdflatex brevets.tex

clean:
	@echo "suppression des fichiers de compilation"
	@rm -f *.log *.aux *.dvi *.toc *.lot *.lof *.out *.nav *.snm

init: clean
	@echo "suppression des fichiers cibles"
	@rm -f *.pdf
