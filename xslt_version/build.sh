#!/bin/sh

xsltproc --xinclude articles_en.xml > articles_en.html
xsltproc --xinclude articles_fr.xml > articles_fr.html

xsltproc --xinclude projects_en.xml > projects_en.html
xsltproc --xinclude projects_fr.xml > projects_fr.html

xsltproc --xinclude tutorials_en.xml > tutorials_en.html
xsltproc --xinclude tutorials_fr.xml > tutorials_fr.html

