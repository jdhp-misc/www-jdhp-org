#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Copyright (c) 2011 Jérémie DECOCK (http://www.jdhp.org)

import xml.etree.ElementTree as ET
import os
import sys
import templates
import getopt
import shutil
import string
import re

LANG_LIST = ('en', 'fr')
DEFAULT_LANG = 'fr'

SRC_DIR  = 'src'      # xml files location
DEST_DIR = 'www'      # (x)html files location

FILES = "http://download.tuxfamily.org/jdhp/"
DEB_DIR = "debian/"
RPM_DIR = "rpm/"
TGZ_DIR = "tarball/"
PDF_DIR = "pdf/"
MAN_DIR = "man/"
IMG_DIR = "image/"
VIDEO_DIR = "video/"
THUMB_DIR = "http://www.jdhp.org/medias/thumbnails/"

INCLUDE_FILES = (os.path.join('misc', 'favicon.ico'),
                 os.path.join('misc', 'robots.txt'))
INCLUDE_DIRS = ('articles', 'css', 'medias')

VERSION = '2.0'

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

Report bugs to <jd.jdhp@gmail.com>.
'''


def main():
    """The main function."""
    
    # Parse options ###########################################################
    base_href = 'http://www.jdhp.org/'

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

    try:
        shutil.rmtree(DEST_DIR)
    except OSError:
        pass
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

    tree = ET.ElementTree()

    print "Parse", os.path.join(SRC_DIR, page + '.xml')
    tree.parse(os.path.join(SRC_DIR, page + '.xml'))

    for lang in LANG_LIST:
        print "Write", os.path.join(DEST_DIR, page + '_' + lang + '.html')
        fd = open(os.path.join(DEST_DIR, page + '_' + lang + '.html'), 'w')

        # HEADER
        page_title = ''
        for elem in tree.findall('name'):
            if elem.attrib['lang'] == lang:
                page_title = el2text(elem)

        page_keywords = ''
        for elem in tree.findall('keywords'):
            if elem.attrib['lang'] == lang:
                page_keywords = el2text(elem)
            
        substitute = {'base_href': base_href,
                      'page_title': page_title,
                      'page_keywords': page_keywords}
        header = templates.HEADER % substitute

        # MENU
        substitute = {
            'lang': lang,
            'home_class': 'selected' if page == 'home' else 'normal',
            'home_label': templates.HOME_LABEL[lang],
            'project_class': 'selected' if page == 'projects' else 'normal',
            'project_label': templates.PROJECTS_LABEL[lang],
            'article_class': 'selected' if page == 'articles' else 'normal',
            'article_label': templates.ARTICLES_LABEL[lang],
            'tutorial_class': 'selected' if page == 'tutorials' else 'normal',
            'tutorial_label': templates.TUTORIALS_LABEL[lang]}
        menu = templates.MENU % substitute

        # FOOTER
        substitute = {'tf_text': templates.TF_TEXT[lang],
                      'xhtml_text': templates.XHTML_TEXT[lang],
                      'css_text': templates.CSS_TEXT[lang]}
        footer = templates.FOOTER % substitute

        # BODY

        # page desc
        page_desc = ''
        for elem in tree.findall('desc'):
            if elem.attrib['lang'] == lang:
                page_desc = templates.PAGE_DESC % {'text': el2html(elem)}

        # table of content
#        group_labels = []
#        for group_elem in tree.findall('group'):
#            for name_elem in group_elem.findall('label'):
#                if name_elem.attrib['lang'] == lang:
#                    substitute = {'id': group_elem.attrib['id'],
#                                  'page': page + "_" + lang + ".html",
#                                  'label': el2text(name_elem)}
#                    tag = templates.TOC_TAG % substitute
#                    group_labels.append(tag)
        page_toc = u''
#        if(len(group_labels) > 0):
#            substitute = {'content': string.join(group_labels)}
#            page_toc = templates.PAGE_TOC % substitute

        # page note
        page_note = ''
        for elem in tree.findall('note'):
            if elem.attrib['lang'] == lang:
                page_note = templates.PAGE_NOTE % {'text': el2html(elem)}

        groups = []
        for group_elem in tree.findall('group'):
            for name_elem in group_elem.findall('label'):
                if name_elem.attrib['lang'] == lang:
                    groups.append((group_elem, name_elem))

        content = u''
        for group, gname in groups:
            items = []
            for item_elem in group.findall('item'):
                for name_elem in item_elem.findall('label'):
                    if name_elem.attrib['lang'] == lang:
                        items.append((item_elem, name_elem))
            if(len(items) > 0):
                # WRITE THE GROUP TAG
                substitute = {'id': group.attrib['id'],
                              'label': el2text(gname)}
                content += templates.GROUP_TAG % substitute

                for item, iname in items:
                    # WRITE THE ITEM TAG
                    substitute = {'id': item.attrib['id'],
                                  'label': el2text(iname)}
                    content += templates.ITEM_TAG % substitute

                    # WRITE THE ITEM PICTURES
                    img_list = []
                    for img_elem in item.findall('picture'):
                        args = {'url': FILES + IMG_DIR + img_elem.attrib['filename'],
                                'thumbnail_url': THUMB_DIR + img_elem.attrib['filename']}
                        img_list.append(templates.PICTURE_TAG[lang].format(**args))

                    if len(img_list) > 0:
                        #substitute = {'content': string.join(img_list, ' ')}  # Display all pictures
                        substitute = {'content': img_list[0]}                  # Display only the first picture
                        content += templates.ITEM_PICTURES % substitute

                    # WRITE THE ITEM VIDEO
                    mov_list = []
                    for img_elem in item.findall('video'):
                        filename = img_elem.attrib['filename']
                        thumbnail_file = string.replace(filename, '.ogv', '.png')
                        substitute = {'url': FILES + VIDEO_DIR + filename,
                                      'thumbnail_url': THUMB_DIR + thumbnail_file}
                        mov_list.append(templates.VIDEO_TAG % substitute)

                    if len(mov_list) > 0:
                        #substitute = {'content': string.join(mov_list, ' ')}  # Display all videos
                        substitute = {'content': mov_list[0]}                  # Display only the first picture
                        content += templates.ITEM_VIDEOS % substitute

                    # WRITE THE ITEM DESC
                    for desc_elem in item.findall('desc'):
                        if desc_elem.attrib['lang'] == lang:
                            substitute = {'desc': el2html(desc_elem)}
                            content += templates.ITEM_DESC % substitute

                    # WRITE THE ITEM LINK
                    for link_elem in item.findall('link'):
                        for label_elem in link_elem.findall('label'):
                            if label_elem.attrib['lang'] == lang:
                                substitute = {'url': link_elem.attrib['url'],
                                              'label': el2text(label_elem)}
                                content += templates.ITEM_LINK % substitute
                
                    # WRITE THE ITEM FILES AND PACKAGES
                    file_content = u''
                    download_list = []
                    for deb_elem in item.findall('debian_package'):
                        args = {'filename': FILES + DEB_DIR + deb_elem.attrib['filename'],
                                'arch': deb_elem.attrib['arch']}
                        download_list.append(templates.DEBIAN_TAG[lang].format(**args))

                    for rpm_elem in item.findall('rpm_package'):
                        args = {'filename': FILES + RPM_DIR + rpm_elem.attrib['filename'],
                                'arch': rpm_elem.attrib['arch']}
                        download_list.append(templates.RPM_TAG[lang].format(**args))

                    for tgz_elem in item.findall('tarball'):
                        for label_elem in tgz_elem.findall('label'):
                            if label_elem.attrib['lang'] == lang:
                                substitute = {'filename': FILES + TGZ_DIR + tgz_elem.attrib['filename'],
                                              'label': el2text(label_elem)}
                                download_list.append(templates.TGZ_TAG % substitute)

                    for pdf_elem in item.findall('pdf'):
                        for label_elem in pdf_elem.findall('label'):
                            if label_elem.attrib['lang'] == lang:
                                substitute = {'filename': FILES + PDF_DIR + pdf_elem.attrib['filename'],
                                              'label': el2text(label_elem)}
                                download_list.append(templates.PDF_TAG % substitute)

                    if len(download_list) > 0:
                        args = {'content': string.join(download_list, ' &#149; ')}
                        file_content += templates.DOWNLOAD_FILES[lang].format(**args)

                    # WRITE THE ITEM SOURCE REPOSITORIES
                    vcs_list = []
                    for git_elem in item.findall('git_repository'):
                        substitute = {'url': git_elem.attrib['url'],
                                      'weburl': git_elem.attrib['weburl']}
                        vcs_list.append(templates.GIT_TAG % substitute)

                    for svn_elem in item.findall('svn_repository'):
                        substitute = {'url': svn_elem.attrib['url'],
                                      'weburl': svn_elem.attrib['weburl']}
                        vcs_list.append(templates.SVN_TAG % substitute)

                    if len(vcs_list) > 0:
                        args = {'content': string.join(vcs_list, ' &#149; ')}
                        file_content += templates.VCS_REPOSITORIES[lang].format(**args)

                    if not file_content == '':
                        substitute = {'content': file_content}
                        content += templates.ITEM_METADATAS % substitute

                    # WRITE THE ITEM LICENSE


        substitute = {'menu': menu,
                      'flag': templates.FLAG_TAG[lang].format(href=page),
                      'page_desc': page_desc,
                      'page_toc': page_toc.encode("utf-8"),
                      'page_note': page_note,
                      'page_content': content.encode("utf-8"),
                      'footer': footer}
        body = templates.BODY % substitute

        # WRITE THE FULL DOCUMENT
        substitute = {'lang': lang,
                      'header': header,
                      'body': body}
        html = templates.HTML % substitute
        #print html

        fd.write(html)
        fd.close()

def childs(element, tag, lang):
    child_list = []
    for child in element.findall(tag):
        if child.attrib['lang'] == lang:
            child_list.append(child)
    return child_list

def el2text(element):
    # Get the text of the element
    text = element.text
    # We need to remove all '\n' to process the string with re
    text = string.replace(text, '\n', '')
    # Remove useless spaces
    text = string.join(string.split(text))
    return text

def el2html(element):
    # Get the xml 'raw' code of the element
    text = ET.tostring(element)
    # We need to remove all '\n' to process the string with re
    text = string.replace(text, '\n', '')
    # Remove useless spaces
    text = string.join(string.split(text))
    # Remove the first and last tags
    text = re.match('[^<]*<[^>]+>(.+)<[^>]+>[^>]*', text).group(1)
    return text

if __name__ == '__main__':
    main()

