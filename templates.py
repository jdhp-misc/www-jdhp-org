#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Copyright (c) 2011 Jérémie DECOCK (http://www.jdhp.org)


# TRANSLATIONS ##################################

tf_text = {'en': 'Hosted by TuxFamily',
           'fr': 'Ce site est hébergé chez TuxFamily'}

xhtml_text = {'en': 'XHTML 1.0 Strict compliant',
              'fr': 'Cette page respecte le standard XHTML 1.0 Strict'}

css_text = {'en': 'CSS 2.0 compliant',
            'fr': 'Cette page respecte le standard CSS 2.0'}

home_label = {'en': 'Home',
              'fr': 'Accueil'}

projects_label = {'en': 'Projects',
                  'fr': 'Travaux'}

articles_label = {'en': 'Articles',
                  'fr': 'Articles'}

tutorials_label = {'en': 'Tutorials',
                   'fr': 'Tutoriels'}

flag_html = {'en' : '''
            <div id="flag">
                <a href="./home_fr.html"><img src="./medias/images/flag_fr.png" title="Version française" alt="Version française" /></a>
                <img src="./medias/images/flag_grey_en.png" title="English version" alt="English version" />
            </div>''',

             'fr' : '''
            <div id="flag">
                <img src="./medias/images/flag_grey_fr.png" title="Version française" alt="Version française" />
                <a href="./home_en.html"><img src="./medias/images/flag_en.png" title="English version" alt="English version" /></a>
            </div>'''}


# TEMPLATES #####################################

HTML = '''
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="%(lang)s" lang="%(lang)s">
%(header)s
%(body)s
</html>
'''

HEADER = '''
    <head>
        <title>JDHP - %(page_title)s</title>
        <base href="%(base_href)s" />
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="author" content="Jérémie DECOCK" />
        <meta name="copyright" content="copyright (c) 2006,2007,2008,2009,2010,2011 Jérémie DECOCK" />
        <meta name="keywords" content="%(page_keywords)s" />
        <link rel="shortcut icon" type="image/png" href="./medias/images/favicon.png" />
        <link rel="stylesheet" type="text/css" href="./css/gray.css" media="screen" title="Normal" />
        <link rel="alternate stylesheet" type="text/css" href="./css/blue.css" media="screen" title="Blue" />
    </head>
'''

BODY = '''
    <body>

        <h1><img src="./medias/images/header.jpeg" title="jdhp.org" alt="jdhp.org" /></h1>

        %(menu)s

        <div id="page">
            %(flag)s

            %(page_desc)s

            %(page_toc)s

            %(page_note)s

            %(page_content)s
        </div>

        %(footer)s

    </body>
'''

MENU = '''
        <ul id="menu">
            <li class="%(home_class)s">    <a href="./home_%(lang)s.html">%(home_label)s</a>        </li>
            <li class="%(project_class)s"> <a href="./projects_%(lang)s.html">%(project_label)s</a>  </li>
            <li class="%(article_class)s"> <a href="./articles_%(lang)s.html">%(article_label)s</a>  </li>
            <li class="%(tutorial_class)s"><a href="./tutorials_%(lang)s.html">%(tutorial_label)s</a></li>
        </ul>
'''

FOOTER = '''
        <div id="footer">
            <a href="http://www.tuxfamily.org/"><img src="./medias/images/tux_family.png" title="%(tf_text)s" alt="%(tf_text)s" /></a>
            <a href="http://validator.w3.org/check?uri=referer"><img src="./medias/images/xhtml.png" title="%(xhtml_text)s" alt="%(xhtml_text)s" /></a>
            <a href="http://jigsaw.w3.org/css-validator/"><img src="./medias/images/css.png" title="%(css_text)s" alt="%(css_text)s" /></a>
        </div>
'''

PAGE_DESC = '''
            <div id="page_desc">
                %(text)s
            </div>
'''

PAGE_TOC = '''
            <ul id="page_toc">%(content)s
            </ul>
'''

TOC_TAG = '''
                <li><a href="#%(id)s">%(label)s</a></li>'''

PAGE_NOTE = '''
            <div id="page_note">
                %(text)s
            </div>
'''

GROUP_TAG = '''
            <h2 id="%(id)s">%(label)s</h2>
'''

ITEM_TAG = '''
                <h3 id="%(id)s">%(label)s</h3>
'''

ITEM_DESC = '''
                    <div class="item_desc">%(desc)s</div>
'''

ITEM_LINK = '''
                    <div class="item_link">
                        <a href="%(url)s">%(label)s</a>
                    </div>
'''

ITEM_METADATAS = '''
                    <div class="item_metadatas">
                        %(content)s
                    </div>
'''

FILES_DOWNLOAD = u'''
                        <div class="item_download">
                            <strong>Télécharger</strong> :%(content)s
                        </div>
''' # TODO : lang

FILES_REPOSITORIES = '''
                        <div class="item_repositories">
                            <strong>Sources</strong> :%(content)s
                        </div>
''' # TODO : lang

DEBIAN_TAG = '''
                                <a href="%(filename)s">Paquet Debian (%(arch)s)</a>''' # TODO : lang

RPM_TAG = '''
                                <a href="%(filename)s">Paquet RPM (%(arch)s)</a>''' # TODO : lang

TGZ_TAG = '''
                                <a href="%(filename)s">%(label)s</a>''' # TODO : lang

PDF_TAG = '''
                                <a href="%(filename)s">%(label)s</a>''' # TODO : lang

GIT_TAG = '''
                                <a href="%(url)s">Git</a>
                                (<a href="%(weburl)s">Gitweb</a>)'''

SVN_TAG = '''
                                <a href="%(url)s">SVN</a>
                                (<a href="%(weburl)s">WebSVN</a>)'''

ITEM_PICTURES = '''
                    <div class="item_thumbnails">%(content)s
                    </div>
'''

PICTURE_TAG = '''
                        <a href="%(url)s"><img src="%(thumbnail_url)s" title="picture" alt="picture" /></a>'''

ITEM_VIDEOS = '''
                    <div class="item_thumbnails">%(content)s
                    </div>
'''

VIDEO_TAG = '''
                        <a href="%(url)s"><img src="%(thumbnail_url)s" title="video" alt="video" /></a>'''
