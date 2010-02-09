#!/bin/sh

#grep href $(find www -name "*.html") | sed -r "s/^.*href=\"([^\"]+)\".*$/\1/" | sort
#grep href $(find www -name "*.html") | sed -r "s/^.*href=\"([^\"]+)\".*$/\1/" | grep -e "^\." | sort
grep href $(find www -name "*.html") | sed -r "s/^.*href=\"([^\"]+)\".*$/\1/" | grep -e "^\." | grep -e "\.html$"  | sort | uniq
