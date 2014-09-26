#!/bin/sh

# See: http://www.microhowto.info/howto/process_an_xml_document_using_an_xslt_stylesheet.html

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

# XSLT1 ONLY
xsltproc --xinclude home_en.xml | tail -n +2 | sed "s/xmlns:xi=\"http:\/\/www.w3.org\/2001\/XInclude\" xmlns=\"\"//g" > www/home_en.html
xsltproc --xinclude home_fr.xml | tail -n +2 | sed "s/xmlns:xi=\"http:\/\/www.w3.org\/2001\/XInclude\" xmlns=\"\"//g" > www/home_fr.html

xsltproc --xinclude articles_en.xml | tail -n +2 | sed "s/xmlns:xi=\"http:\/\/www.w3.org\/2001\/XInclude\" xmlns=\"\"//g" > www/articles_en.html
xsltproc --xinclude articles_fr.xml | tail -n +2 | sed "s/xmlns:xi=\"http:\/\/www.w3.org\/2001\/XInclude\" xmlns=\"\"//g" > www/articles_fr.html

xsltproc --xinclude projects_en.xml | tail -n +2 | sed "s/xmlns:xi=\"http:\/\/www.w3.org\/2001\/XInclude\" xmlns=\"\"//g" > www/projects_en.html
xsltproc --xinclude projects_fr.xml | tail -n +2 | sed "s/xmlns:xi=\"http:\/\/www.w3.org\/2001\/XInclude\" xmlns=\"\"//g" > www/projects_fr.html

xsltproc --xinclude tutorials_en.xml | tail -n +2 | sed "s/xmlns:xi=\"http:\/\/www.w3.org\/2001\/XInclude\" xmlns=\"\"//g" > www/tutorials_en.html
xsltproc --xinclude tutorials_fr.xml | tail -n +2 | sed "s/xmlns:xi=\"http:\/\/www.w3.org\/2001\/XInclude\" xmlns=\"\"//g" > www/tutorials_fr.html

# Well... I don't use redirection (http, meta, script, ...) but a simple copy in order to avoid problems with web indexing (Google and so).
cp -a www/home_en.html www/index.html
#ln --symbolic home_en.html www/index.html
cp -a misc/favicon.ico www/
cp -a misc/robots.txt www/
cp -a css www/
cp -a medias www/
cp -a hevea www/
cp -a html www/

## XSLT2
#
## aptitude install libsaxonb-java
#
## Note that the package libsaxon-java is not Saxon-B (it contains Saxon-6, an older version described below).
## Once installed you will need to place the Saxon JAR file on the CLASSPATH:
#
#export CLASSPATH=$CLASSPATH:/usr/share/java/saxonb.jar
#
## This affects only the process in which it is executed and processes descended
## from it. If you want to alter the CLASSPATH permanently then you will need to
## set it in a configuration file such as ~/.profile.
#
## Documents are processed by invoking the relevant Java class name, which (for
## this variant of Saxon) is net.sf.saxon.Transform:
#
##java net.sf.saxon.Transform -o:output.xml -s:projects_fr.xml -xsl:style.xsl
#java net.sf.saxon.Transform -a -o:test.html -s:projects_fr.xml

