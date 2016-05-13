#!/bin/sh

if [ -z ${JDHP_ROOT_PATH} ] || [ \! -d ${JDHP_ROOT_PATH} ]
then
    echo "ERROR: the JDHP_ROOT_PATH environment variable is not set or not valid."
    exit 1
fi

LOCAL_DIR_PATH=${JDHP_ROOT_PATH}/www.jdhp.org
REMOTE_DIR_PATH="tf:~/jdhp/jdhp.org-web/htdocs/docs"

#rsync -a -v -e ssh --delete ${LOCAL_DIR_PATH}/docs/* ${REMOTE_DIR_PATH}/
rsync -a -v -e ssh ${LOCAL_DIR_PATH}/docs/* ${REMOTE_DIR_PATH}/

