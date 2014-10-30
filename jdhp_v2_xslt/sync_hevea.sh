#!/bin/sh

JDHP_LOCAL_PATH=~/git/pub/jdhp/jdhp_v2_xslt

rsync -a -v -e ssh --delete ${JDHP_LOCAL_PATH}/hevea/* gremy@ssh.tuxfamily.org:~/jdhp/jdhp.org-web/htdocs/hevea/

