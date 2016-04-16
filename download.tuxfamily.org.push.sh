#!/bin/sh

LOCAL_DIR_PATH=${JDHP_ROOT_PATH}/download.tuxfamily.org
REMOTE_DIR_PATH="tf:~/jdhp/jdhp-repository"


if [ -d ${LOCAL_DIR_PATH} ]
then
    rsync -a -v -e ssh --delete ${LOCAL_DIR_PATH}/ ${REMOTE_DIR_PATH}/
else
    echo "ERROR: ${LOCAL_DIR_PATH} doesn't exist!"
fi

