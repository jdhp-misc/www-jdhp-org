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
        <link rel="stylesheet" type="text/css" href="./css/metal_screen_3.css" media="screen" title="Normal" />
        <link rel="alternate stylesheet" type="text/css" href="./css/metal_screen.css" media="screen" title="Firefox" />
    </head>
'''

BODY = '''
    <body>

        <h1><img src="./medias/images/header.jpeg" title="jdhp.org" alt="jdhp.org" /></h1>

        %(menu)s

        <div id="content_bloc">
            %(flag)s

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

