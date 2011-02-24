#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Copyright (c) 2011 Jérémie DECOCK (http://www.jdhp.org)

from xml.dom import minidom
import os
import sys
import templates
import getopt
import shutil

SRC_DIR  = 'src'      # xml files location
DEST_DIR = 'test'     # (x)html files location
LANG_LIST = ('en', 'fr')
DEFAULT_LANG = 'fr'

INCLUDE_FILES = (os.path.join('misc', 'favicon.ico'),
                 os.path.join('misc', 'robots.txt'))
INCLUDE_DIRS = ('css', 'medias')

VERSION = '1.0'

def usage():
    """Print help message"""

    print '''JDHP parser.

Usage: parser [OPTION]...
    
Options:
    -b, --base=HREF
        specifies a base URL for all relative URLs

    -v, --version
        output version information and exit

    -h, --help
        display this help and exit

Examples:
    parser -b "file:///tmp/jdhp.org/www/"

    parser -b "$(pwd)/www/"

Report bugs to <gremy@tuxfamily.org>.
'''


def main():
    """The main function."""
    
    # Parse options ###########################################################
    base_href = 'http://127.0.0.1/jdhp.org/'

    try:
        opts, args = getopt.getopt(sys.argv[1:],
                                   'b:vh',
                                   ["base", "version", "help"])
    except getopt.GetoptError, err:
        # will print something like "option -x not recognized"
        print str(err) 
        usage()
        sys.exit(1)
 
    for o, a in opts:
        if o in ("-b", "--base"):
            base_href = a
        elif o in ("-v", "--version"):
            print 'JDHP Parser ', VERSION
            print
            print 'Copyright (c) 2010 Jérémie DECOCK (http://www.jdhp.org)'
            print 'This is free software;',
            print 'see the source for copying conditions.',
            print 'There is NO warranty; not even for MERCHANTABILITY',
            print 'or FITNESS FOR A PARTICULAR PURPOSE.'
            sys.exit(0)
        elif o in ("-h", "--help"):
            usage()
            sys.exit(0)
        else:
            assert False, "unhandled option"

    # Parse XML files #########################################################
    init()
    parse('home', base_href)
    parse('articles', base_href)
    parse('projects', base_href)
    parse('tutorials', base_href)
    shutil.copy2(os.path.join(DEST_DIR, 'home_' + DEFAULT_LANG + '.html'),
                 os.path.join(DEST_DIR, 'index.html'))


def init():
    """Initialize output directory."""

    shutil.rmtree(DEST_DIR)
    os.mkdir(DEST_DIR)
    print "init", DEST_DIR

    for src in INCLUDE_FILES:
        print "copy", os.path.join(SRC_DIR, src), "to", DEST_DIR
        shutil.copy2(os.path.join(SRC_DIR, src), DEST_DIR)

    for src in INCLUDE_DIRS:
        print "copy", os.path.join(SRC_DIR, src),
        print "to", os.path.join(DEST_DIR, src)
        shutil.copytree(os.path.join(SRC_DIR, src), os.path.join(DEST_DIR, src))


def parse(page, base_href):
    """Parse an XML file."""

    print "Parse", os.path.join(SRC_DIR, page + '.xml')
    dom = minidom.parse(os.path.join(SRC_DIR, page + '.xml'))

    for lang in LANG_LIST:
        print "Write", os.path.join(DEST_DIR, page + '_' + lang + '.html')
        fd = open(os.path.join(DEST_DIR, page + '_' + lang + '.html'), 'w')

        # HEADER
        substitute = {'page_title': 'TEST_TITLE',
                      'base_href': base_href,
                      'page_keywords': 'TEST_KEYWORDS'}
        header = templates.HEADER % substitute

        # MENU
        substitute = {
            'lang': lang,
            'home_class': 'selected' if page == 'home' else 'normal',
            'home_label': templates.home_label[lang],
            'project_class': 'selected' if page == 'projects' else 'normal',
            'project_label': templates.projects_label[lang],
            'article_class': 'selected' if page == 'articles' else 'normal',
            'article_label': templates.articles_label[lang],
            'tutorial_class': 'selected' if page == 'tutorials' else 'normal',
            'tutorial_label': templates.tutorials_label[lang]}
        menu = templates.MENU % substitute

        # FOOTER
        substitute = {'tf_text': templates.tf_text[lang],
                      'xhtml_text': templates.xhtml_text[lang],
                      'css_text': templates.css_text[lang]}
        footer = templates.FOOTER % substitute

        # BODY
        substitute = {'menu': menu,
                      'flag': templates.flag_html[lang],
                      #'flag': templates.flag_html[lang] % page,
                      #'flag': templates.flag_html[lang].format(page),
                      'footer': footer}
        body = templates.BODY % substitute

        # WRITE THE FULL DOCUMENT
        substitute = {'lang': lang,
                      'header': header,
                      'body': body}
        fd.write(templates.HTML % substitute)

        fd.close()

if __name__ == '__main__':
    main()

