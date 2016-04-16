#!/bin/sh

LOCAL_DIR_PATH=${JDHP_ROOT_PATH}/download.tuxfamily.org
REMOTE_DIR_PATH="tf:~/jdhp/jdhp-repository"

rsync -a -v -e ssh --delete ${REMOTE_DIR_PATH}/ ${LOCAL_DIR_PATH}/
