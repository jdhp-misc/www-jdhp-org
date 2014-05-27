#!/bin/sh

# "tail -n +2" removes the first line of each generated html files
# "<?xml version="1.0" encoding="UTF-8"?>".
# Otherwise pages won't be displayed on hosts using PhP (this is the case for https://www.lri.fr/ !!)
# See: http://stackoverflow.com/questions/4361750/why-when-add-xml-version-1-0-encoding-utf-8-to-web-page-dont-work-on-ho
# 
#    - The document is being processed as PHP
#    - Short Tags are turned on
#    so the server is trying to process the XML declaration as PHP code. Normally I'd expect an error message, but perhaps there is a PHP setting in play that suppresses errors to the client to avoid leaking data that could be potentially useful to someone trying a security exploit.
#    Just remove it.
#    - UTF-8 is the default
#    - version 1.0 is the default
#    - It is optional in the spec
#    - Given a text/html content-type, an XML prolog will trigger IE6's quirks mode
#    The latter is undesirable. The former all mean it makes no difference

xsltproc --xinclude home_en.xml | tail -n +2 > www/home_en.html
xsltproc --xinclude home_fr.xml | tail -n +2 > www/home_fr.html

xsltproc --xinclude articles_en.xml | tail -n +2 > www/articles_en.html
xsltproc --xinclude articles_fr.xml | tail -n +2 > www/articles_fr.html

xsltproc --xinclude projects_en.xml | tail -n +2 > www/projects_en.html
xsltproc --xinclude projects_fr.xml | tail -n +2 > www/projects_fr.html

xsltproc --xinclude tutorials_en.xml | tail -n +2 > www/tutorials_en.html
xsltproc --xinclude tutorials_fr.xml | tail -n +2 > www/tutorials_fr.html

