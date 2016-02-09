#!/bin/sh

DST="tf:~/jdhp/jdhp.org-web/htdocs/hevea"
JDHP_LOCAL_PATH=~/jdhp/jdhp_v2_xslt

rsync -a -v -e ssh --delete ${JDHP_LOCAL_PATH}/hevea/* ${DST}/

