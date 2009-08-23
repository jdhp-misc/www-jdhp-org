make_all: les_wikis_en_entreprise.pdf les_wikis_en_entreprise.html

les_wikis_en_entreprise.pdf: les_wikis_en_entreprise.tex
	pdflatex les_wikis_en_entreprise.tex
	pdflatex les_wikis_en_entreprise.tex

les_wikis_en_entreprise.html: les_wikis_en_entreprise.tex
	hevea les_wikis_en_entreprise.tex

clean:
	@echo "suppression des fichiers de compilation"
	@rm -f *.log *.aux *.dvi *.toc *.lot *.lof *.out *.haux

init: clean
	@echo "suppression des fichiers cibles"
	@rm -f *.pdf *.html
