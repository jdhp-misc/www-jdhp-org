#!/bin/sh

xsltproc --xinclude home_en.xml > www/home_en.html
xsltproc --xinclude home_fr.xml > www/home_fr.html

xsltproc --xinclude articles_en.xml > www/articles_en.html
xsltproc --xinclude articles_fr.xml > www/articles_fr.html

xsltproc --xinclude projects_en.xml > www/projects_en.html
xsltproc --xinclude projects_fr.xml > www/projects_fr.html

xsltproc --xinclude tutorials_en.xml > www/tutorials_en.html
xsltproc --xinclude tutorials_fr.xml > www/tutorials_fr.html

