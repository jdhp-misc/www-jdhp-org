make_all: tutoriel_vim_spellfr.pdf tutoriel_vim_spellfr.html

tutoriel_vim_spellfr.pdf: tutoriel_vim_spellfr.tex
	pdflatex tutoriel_vim_spellfr.tex

tutoriel_vim_spellfr.html: tutoriel_vim_spellfr.tex
	hevea tutoriel_vim_spellfr.tex

clean:
	@echo "suppression des fichiers de compilation"
	@rm -f *.log *.aux *.dvi *.toc *.lot *.lof *.out *.haux

init: clean
	@echo "suppression des fichiers cibles"
	@rm -f *.pdf *.html
