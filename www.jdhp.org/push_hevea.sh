#!/bin/sh

DST="tf:~/jdhp/jdhp.org-web/htdocs/hevea"
JDHP_LOCAL_PATH=~/jdhp/www.jdhp.org

rsync -a -v -e ssh --delete ${JDHP_LOCAL_PATH}/hevea/* ${DST}/

