make_all: droits_auteurs.pdf droits_auteurs.html

droits_auteurs.pdf: droits_auteurs.tex
	pdflatex droits_auteurs.tex
	pdflatex droits_auteurs.tex

droits_auteurs.html: droits_auteurs.tex
	hevea droits_auteurs.tex

clean:
	@echo "suppression des fichiers de compilation"
	@rm -f *.log *.aux *.dvi *.toc *.lot *.lof *.out *.haux

init: clean
	@echo "suppression des fichiers cibles"
	@rm -f *.pdf *.html
