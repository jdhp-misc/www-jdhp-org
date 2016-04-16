#!/bin/sh

LOCAL_DIR_PATH=${JDHP_ROOT_PATH}/www.jdhp.org
REMOTE_DIR_PATH="tf:~/jdhp/jdhp.org-web/htdocs"

${JDHP_ROOT_PATH}/www.jdhp.org/clean.sh
${JDHP_ROOT_PATH}/www.jdhp.org/build.sh

rsync -a -v -e ssh --delete ${LOCAL_DIR_PATH}/www/* ${REMOTE_DIR_PATH}/

${JDHP_ROOT_PATH}/www.jdhp.org/push_hevea.sh

