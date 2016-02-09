#!/bin/sh

FILE_REMOTE_PATH="tf:~/jdhp/jdhp-repository"
FILE_LOCAL_PATH=~/jdhp/download.tuxfamily.org

rsync -a -v -e ssh --delete ${FILE_REMOTE_PATH}/ ${FILE_LOCAL_PATH}/
