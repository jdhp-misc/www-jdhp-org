<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output method="xml" indent="yes" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd" />

    <xsl:template match="/">

        <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">

            <head>
                <title>JDHP - <xsl:value-of select="/page/name" /></title>
                <base href="{/page/common/base/@href}" />
                <meta http-equiv="content-type" content="text/html; charset=utf-8" />
                <meta name="author" content="Jérémie DECOCK" />
                <meta name="copyright" content="copyright (c) 2006,2007,2008,2009,2010,2011,2012,2014 Jérémie DECOCK" />
                <meta name="keywords" content="{/page/keywords}" />
                <link rel="shortcut icon" type="image/png" href="./medias/images/favicon.png" />
                <link rel="stylesheet" type="text/css" href="./css/blue.css" media="screen" title="Normal" />
                <link rel="alternate stylesheet" type="text/css" href="./css/gray.css" media="screen" title="Gray" />
            </head>

            <body>
                <h1><img src="./medias/images/header.jpeg" title="jdhp.org" alt="jdhp.org" /></h1>
                
                <!-- MENU -->
                <ul id="menu">
 
                    <li>
                        <xsl:attribute name="class">
                            <xsl:choose>
                                <xsl:when test="/page/@id = 'home'">selected</xsl:when>
                                <xsl:otherwise>normal</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <a href="{/page/common_lang/menu/home/@href}">
                            <xsl:value-of select="/page/common_lang/menu/home/@label" />
                        </a>
                    </li>

                    <li>
                        <xsl:attribute name="class">
                            <xsl:choose>
                                <xsl:when test="/page/@id = 'projects'">selected</xsl:when>
                                <xsl:otherwise>normal</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <a href="{/page/common_lang/menu/projects/@href}">
                            <xsl:value-of select="/page/common_lang/menu/projects/@label" />
                        </a>
                    </li>

                    <li>
                        <xsl:attribute name="class">
                            <xsl:choose>
                                <xsl:when test="/page/@id = 'articles'">selected</xsl:when>
                                <xsl:otherwise>normal</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <a href="{/page/common_lang/menu/articles/@href}">
                            <xsl:value-of select="/page/common_lang/menu/articles/@label" />
                        </a>
                    </li>

                    <li>
                        <xsl:attribute name="class">
                            <xsl:choose>
                                <xsl:when test="/page/@id = 'tutorials'">selected</xsl:when>
                                <xsl:otherwise>normal</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
                        <a href="{/page/common_lang/menu/tutorials/@href}">
                            <xsl:value-of select="/page/common_lang/menu/tutorials/@label" />
                        </a>
                    </li>
                </ul>

                <!-- PAGE -->
                <div id="page">
                    
                    <!-- FLAGS -->
                    <div id="flag">
                        <xsl:for-each select="/page/common_lang/flag">

                            <a href="{/page/@id}_{@suffix}.html">
                                <img src="{@src}" title="{@title}" alt="{@alt}" />
                            </a>

                        </xsl:for-each>
                    </div>

                    
                    <!-- PAGE DESCRIPTION -->
                    <div id="page_desc">
                        <!-- xsl:copy-of excluding parent: see http://stackoverflow.com/questions/1755661/xslcopy-of-excluding-parent -->
                        <!-- copy elements but remove unused namespace(s): see http://stackoverflow.com/questions/1074767/xsl-copy-elements-but-remove-unused-namespaces -->
                        <xsl:copy-of select="/page/desc/node()" /> <!-- TODO http://stackoverflow.com/questions/19998180/xsl-copy-nodes-without-xmlns -->
                    </div>

                    <!-- PAGE NOTES -->
                    <xsl:choose>
                        <xsl:when test="/page/note">
                            <div id="page_note">
                                <!-- xsl:copy-of excluding parent: see http://stackoverflow.com/questions/1755661/xslcopy-of-excluding-parent -->
                                <!-- copy elements but remove unused namespace(s): see http://stackoverflow.com/questions/1074767/xsl-copy-elements-but-remove-unused-namespaces -->
                                <xsl:copy-of select="/page/note/node()" copy-namespaces="no" /> <!-- TODO http://stackoverflow.com/questions/19998180/xsl-copy-nodes-without-xmlns -->
                            </div>
                        </xsl:when>
                    </xsl:choose>

                    <!-- GROUPS -->
                    <xsl:for-each select="/page/group">
                        <h2 id="{@id}">
                            <xsl:value-of select="label" />
                        </h2>

                        <xsl:for-each select="./item">
                            <h3 id="{@id}">
                                <xsl:value-of select="label" />
                            </h3>

                            <!-- PICTURES -->
                            <xsl:choose>
                                <xsl:when test="picture">
                                    <div class="item_thumbnails">
                                        <a href="{/page/common/img_base/@href}{picture/@filename}">
                                        <xsl:choose>
                                            <xsl:when test="picture/@thumbnail_filename">
                                                <img src="{/page/common/thumbnail_base/@href}{picture/@thumbnail_filename}" title="{/page/common_lang/i18n/image/@translation}" alt="{/page/common_lang/i18n/image/@translation}" />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <img src="{/page/common/thumbnail_base/@href}{picture/@filename}" title="{/page/common_lang/i18n/image/@translation}" alt="{/page/common_lang/i18n/image/@translation}" />
                                            </xsl:otherwise>
                                        </xsl:choose>
                                        </a>
                                    </div>
                                </xsl:when>
                            </xsl:choose>

                            <!-- VIDEOS -->
                            <xsl:choose>
                                <xsl:when test="video">
                                    <div class="item_thumbnails">
                                        <a href="{/page/common/video_base/@href}{video/@filename}">
                                            <img src="{/page/common/thumbnail_base/@href}{video/@thumbnail_filename}" title="{/page/common_lang/i18n/video/@translation}" alt="{/page/common_lang/i18n/video/@translation}" />
                                        </a>
                                    </div>
                                </xsl:when>
                            </xsl:choose>

                            <!-- DESC -->
                            <div class="item_desc">
                                <!-- xsl:copy-of excluding parent: see http://stackoverflow.com/questions/1755661/xslcopy-of-excluding-parent -->
                                <!-- copy elements but remove unused namespace(s): see http://stackoverflow.com/questions/1074767/xsl-copy-elements-but-remove-unused-namespaces -->
                                <xsl:copy-of select="desc/node()" copy-namespaces="no" /> <!-- TODO http://stackoverflow.com/questions/19998180/xsl-copy-nodes-without-xmlns -->
                            </div>

                            <!-- LINK -->
                            <xsl:choose>
                                <xsl:when test="link">
                                    <div class="item_link">
                                        <a href="{link/@url}"><xsl:value-of select="link/label" /></a>
                                    </div>
                                </xsl:when>
                            </xsl:choose>

                            <!-- BIB (FOR ACADEMIC ARTICLES) -->
                            <xsl:choose>
                                <xsl:when test="bib">
                                    <div class="item_bib">
                                        <p class="bib_header">
                                            <xsl:value-of select="bib/@label" />
                                        </p>
                                        <p class="bib_body">
                                            <!-- xsl:copy-of excluding parent: see http://stackoverflow.com/questions/1755661/xslcopy-of-excluding-parent -->
                                            <!-- copy elements but remove unused namespace(s): see http://stackoverflow.com/questions/1074767/xsl-copy-elements-but-remove-unused-namespaces -->
                                            <xsl:copy-of select="bib/node()" copy-namespaces="no" /> <!-- TODO http://stackoverflow.com/questions/19998180/xsl-copy-nodes-without-xmlns -->
                                        </p>
                                    </div>
                                </xsl:when>
                            </xsl:choose>

                            <!-- METADATAS -->
                            <xsl:choose>
                                <xsl:when test="pdf or open_archive or repository or archive or debian_package">
                                    <div class="item_metadatas">

                                        <!-- HAL -->
                                        <xsl:choose>
                                            <xsl:when test="open_archive">
                                                <div class="item_open_archive">
                                                    <strong><xsl:value-of select="/page/common_lang/i18n/open_archive/@translation" /></strong> :
                                                    <a href="{./open_archive/@url}">
                                                        <xsl:value-of select="./open_archive/@label" />
                                                    </a>
                                                </div>
                                            </xsl:when>
                                        </xsl:choose>

                                        <!-- DOWNLOAD -->
                                        <xsl:choose>
                                            <xsl:when test="pdf or archive or debian_package">
                                                <div class="item_download">
                                                    <strong><xsl:value-of select="/page/common_lang/i18n/download/@translation" /></strong> :

                                                    <xsl:for-each select="./pdf">
                                                        <xsl:choose>
                                                            <xsl:when test="@url">
                                                                <a href="{@url}">
                                                                    <xsl:value-of select="@label" />
                                                                </a> &#160;                       <!-- TODO séparateur quand il y a plusieurs pdf http://stackoverflow.com/questions/2817664/xsl-how-to-tell-if-element-is-last-in-series   and   http://stackoverflow.com/questions/1461649/how-to-insert-nbsp-in-xslt  -->
                                                            </xsl:when>
                                                            <xsl:otherwise>
                                                                <a href="{/page/common/pdf_base/@href}{@filename}">
                                                                    <xsl:value-of select="@label" />
                                                                </a> &#160;                       <!-- TODO séparateur quand il y a plusieurs pdf http://stackoverflow.com/questions/2817664/xsl-how-to-tell-if-element-is-last-in-series   and   http://stackoverflow.com/questions/1461649/how-to-insert-nbsp-in-xslt  -->
                                                            </xsl:otherwise>
                                                        </xsl:choose>
                                                    </xsl:for-each>

                                                    <xsl:for-each select="./archive">
                                                        <a href="{/page/common/archive_base/@href}{@filename}">
                                                            <xsl:value-of select="label" />
                                                        </a> &#160;                      <!-- TODO séparateur quand il y a plusieurs pdf http://stackoverflow.com/questions/2817664/xsl-how-to-tell-if-element-is-last-in-series   and   http://stackoverflow.com/questions/1461649/how-to-insert-nbsp-in-xslt  -->
                                                    </xsl:for-each>

                                                    <xsl:for-each select="./debian_package">
                                                        <a href="{/page/common/debian_package_base/@href}{@filename}">
                                                            <xsl:value-of select="/page/common_lang/i18n/debian_package/@translation" /> (<xsl:value-of select="@arch" />)
                                                        </a> &#160;                       <!-- TODO séparateur quand il y a plusieurs pdf http://stackoverflow.com/questions/2817664/xsl-how-to-tell-if-element-is-last-in-series   and   http://stackoverflow.com/questions/1461649/how-to-insert-nbsp-in-xslt  -->
                                                    </xsl:for-each>

                                                </div>
                                            </xsl:when>
                                        </xsl:choose>

                                        <!-- REPOSITORIES (GIT/SVN) -->
                                        <xsl:choose>
                                            <xsl:when test="repository">
                                                <div class="item_repository">
                                                    <strong><xsl:value-of select="/page/common_lang/i18n/source_code/@translation" /></strong> :

                                                    <xsl:for-each select="./repository">
                                                        <xsl:choose>
                                                            <!-- GIT -->
                                                            <xsl:when test="@type='git'">
                                                                <a href="{@url}">Git</a> (<a href="{@weburl}">Gitweb</a>)
                                                                &#160;
                                                                <!-- TODO séparateur quand il y a plusieurs referentiels http://stackoverflow.com/questions/2817664/xsl-how-to-tell-if-element-is-last-in-series   and   http://stackoverflow.com/questions/1461649/how-to-insert-nbsp-in-xslt  -->
                                                            </xsl:when>

                                                            <!-- SVN -->
                                                            <xsl:when test="@type='svn'">
                                                                <a href="{@url}">SVN</a> (<a href="{@weburl}">WebSVN</a>)
                                                                &#160;
                                                                <!-- TODO séparateur quand il y a plusieurs referentiels http://stackoverflow.com/questions/2817664/xsl-how-to-tell-if-element-is-last-in-series   and   http://stackoverflow.com/questions/1461649/how-to-insert-nbsp-in-xslt  -->
                                                            </xsl:when>
                                                        </xsl:choose>
                                                    </xsl:for-each>

                                                </div>
                                            </xsl:when>
                                        </xsl:choose>

                                    </div>
                                </xsl:when>
                            </xsl:choose> <!-- METADATAS -->

                        </xsl:for-each> <!-- ITEMS -->

                    </xsl:for-each> <!-- GROUPS -->
                </div> <!-- PAGE -->

                <div id="footer">
                    <a href="http://www.tuxfamily.org/"><img src="./medias/images/tux_family.png" title="Ce site est hébergé chez TuxFamily" alt="Ce site est hébergé chez TuxFamily" /></a>
                    <a href="http://validator.w3.org/check?uri=referer"><img src="./medias/images/xhtml.png" title="Cette page respecte le standard XHTML 1.0 Strict" alt="Cette page respecte le standard XHTML 1.0 Strict" /></a>
                    <a href="http://jigsaw.w3.org/css-validator/"><img src="./medias/images/css.png" title="Cette page respecte le standard CSS 2.0" alt="Cette page respecte le standard CSS 2.0" /></a>
                </div>

            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>