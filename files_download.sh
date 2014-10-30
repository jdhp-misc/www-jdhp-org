#!/bin/sh

JDHP_LOCAL_PATH=~/git/pub/jdhp

rsync -a -v -e ssh --delete gremy@ssh.tuxfamily.org:/home/jdhp/jdhp-repository/ ${JDHP_LOCAL_PATH}/files/
