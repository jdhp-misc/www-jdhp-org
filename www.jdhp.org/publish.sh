#!/bin/sh

JDHP_ROOT_PATH=~/jdhp/www.jdhp.org

LOCAL_DIR_PATH=~/jdhp/www.jdhp.org
REMOTE_DIR_PATH="tf:~/jdhp/jdhp.org-web/htdocs"

${JDHP_ROOT_PATH}/clean.sh
${JDHP_ROOT_PATH}/build.sh

rsync -a -v -e ssh --delete ${LOCAL_DIR_PATH}/www/* ${REMOTE_DIR_PATH}/

${JDHP_ROOT_PATH}/push_hevea.sh

