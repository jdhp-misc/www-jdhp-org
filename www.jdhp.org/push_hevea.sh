#!/bin/sh

LOCAL_DIR_PATH=~/jdhp/www.jdhp.org
REMOTE_DIR_PATH="tf:~/jdhp/jdhp.org-web/htdocs/hevea"

rsync -a -v -e ssh --delete ${LOCAL_DIR_PATH}/hevea/* ${REMOTE_DIR_PATH}/

