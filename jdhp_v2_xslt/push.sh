#!/bin/sh

DST="tf:~/jdhp/jdhp.org-web/htdocs"

./clean.sh
./build.sh

rsync -a -v -e ssh --delete www/* ${DST}/

./sync_hevea.sh

