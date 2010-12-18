#!/bin/sh

rsync -a -v -e ssh --delete gremy@ssh.tuxfamily.org:/home/jdhp/jdhp-repository/ ./files/
