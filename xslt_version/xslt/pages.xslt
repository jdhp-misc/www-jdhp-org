<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>

    <xsl:template match="/">

        <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" lang="fr">

            <head>
                <title>JDHP - <xsl:value-of select="/page/name" /></title>
                <base href="{/page/common/base/@href}" />
                <meta http-equiv="content-type" content="text/html; charset=utf-8" />
                <meta name="author" content="Jérémie DECOCK" />
                <meta name="copyright" content="copyright (c) 2006,2007,2008,2009,2010,2011,2012 Jérémie DECOCK" />
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
                        <xsl:value-of select="/page/desc" />
                    </div>

                    <!-- GROUPS -->
                    <xsl:for-each select="/page/group">
                        <h2 id="{@id}"><xsl:value-of select="label" /></h2>

                        <xsl:for-each select="./item">
                            <h3 id="vim_spell"><xsl:value-of select="label" /></h3>

                            <div class="item_desc"><xsl:value-of select="desc" /></div>

                            <!-- link -->
                            <xsl:choose>
                                <xsl:when test="link">
                                    <div class="item_link">
                                        <a href="{link/@url}"><xsl:value-of select="link/label" /></a>
                                    </div>
                                </xsl:when>
                            </xsl:choose>

                            <!-- metadatas -->
                            <!--
                            <div class="item_metadatas">
                                TODO
                            </div>
                            -->

                        </xsl:for-each>

                    </xsl:for-each>
                </div>

                <div id="footer">
                    <a href="http://www.tuxfamily.org/"><img src="./medias/images/tux_family.png" title="Ce site est hébergé chez TuxFamily" alt="Ce site est hébergé chez TuxFamily" /></a>
                    <a href="http://validator.w3.org/check?uri=referer"><img src="./medias/images/xhtml.png" title="Cette page respecte le standard XHTML 1.0 Strict" alt="Cette page respecte le standard XHTML 1.0 Strict" /></a>
                    <a href="http://jigsaw.w3.org/css-validator/"><img src="./medias/images/css.png" title="Cette page respecte le standard CSS 2.0" alt="Cette page respecte le standard CSS 2.0" /></a>
                </div>

            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
