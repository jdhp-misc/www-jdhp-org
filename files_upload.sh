#!/bin/sh

rsync -a -v -e ssh --delete ./files/ gremy@ssh.tuxfamily.org:/home/jdhp/jdhp-repository/
