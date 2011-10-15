#!/bin/sh

# Example : ./crawl.sh /tmp/jdhp.org/www/ | less

WWW=$1

for FILE in $(find ${WWW} -name "*.html")
do
    echo "${FILE}:"
    grep href ${FILE} | sed -r "s/^.*href=\"([^\"]+)\".*$/\1/" | grep -e "^\." | grep -e "\.html$" | sort | uniq | sed -r "s/^/   /"
done
