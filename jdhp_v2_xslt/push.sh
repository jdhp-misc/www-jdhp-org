#!/bin/sh

./clean.sh
./build.sh

#scp -r www/* gremy@ssh.tuxfamily.org:~/jdhp/jdhp.org-web/htdocs/

rsync -a -v -e ssh --delete www/* gremy@ssh.tuxfamily.org:~/jdhp/jdhp.org-web/htdocs/

