#!/bin/sh

if [ -z ${JDHP_ROOT_PATH} ] || [ \! -d ${JDHP_ROOT_PATH} ]
then
    echo "ERROR: the JDHP_ROOT_PATH environment variable is not set or not valid."
    exit 1
fi

LOCAL_DIR_PATH=${JDHP_ROOT_PATH}/www.jdhp.org
REMOTE_DIR_PATH="tf:~/jdhp/jdhp.org-web/htdocs"

${JDHP_ROOT_PATH}/www.jdhp.org/clean.sh
${JDHP_ROOT_PATH}/www.jdhp.org/build.sh

rsync -a -v -e ssh --exclude="/docs/" --delete ${LOCAL_DIR_PATH}/www/* ${REMOTE_DIR_PATH}/
scp ${LOCAL_DIR_PATH}/www/.htaccess ${REMOTE_DIR_PATH}/

#${JDHP_ROOT_PATH}/www.jdhp.org/push_docs.sh

