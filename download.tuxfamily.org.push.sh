#!/bin/sh

if [ -z ${JDHP_ROOT_PATH} ] || [ \! -d ${JDHP_ROOT_PATH} ]
then
    echo "ERROR: the JDHP_ROOT_PATH environment variable is not set or not valid."
    exit 1
fi

LOCAL_DIR_PATH=${JDHP_ROOT_PATH}/download.tuxfamily.org
REMOTE_DIR_PATH="tf:~/jdhp/jdhp-repository"

if [ -d ${LOCAL_DIR_PATH} ]
then
    #rsync -a -v -e ssh --delete ${LOCAL_DIR_PATH}/ ${REMOTE_DIR_PATH}/
    rsync -a -v -e ssh ${LOCAL_DIR_PATH}/ ${REMOTE_DIR_PATH}/
else
    echo "ERROR: ${LOCAL_DIR_PATH} doesn't exist!"
    exit 1
fi

