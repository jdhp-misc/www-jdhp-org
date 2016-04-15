#!/bin/sh

LOCAL_DIR_PATH=~/jdhp/download.tuxfamily.org
REMOTE_DIR_PATH="tf:~/jdhp/jdhp-repository"

rsync -a -v -e ssh --delete ${LOCAL_DIR_PATH}/ ${REMOTE_DIR_PATH}/
