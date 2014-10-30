#!/bin/sh

JDHP_LOCAL_PATH=~/git/pub/jdhp

rsync -a -v -e ssh --delete ${JDHP_LOCAL_PATH}/files/ gremy@ssh.tuxfamily.org:/home/jdhp/jdhp-repository/

