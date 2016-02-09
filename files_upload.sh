#!/bin/sh

REMOTE_PATH="tf:~/jdhp/jdhp-repository"
JDHP_LOCAL_PATH=~/jdhp

rsync -a -v -e ssh --delete ${JDHP_LOCAL_PATH}/files/ ${REMOTE_PATH}/

