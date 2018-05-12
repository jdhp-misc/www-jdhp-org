# TODO List

## DEV URGENT

- Les sites non "mobile friendly" seront bientôt moins bien classés dans google search.
  JDHP n'est pas "mobile friendly" d'après l'outil de test de Google: https://www.google.com/webmasters/tools/mobile-friendly/?url=www.jdhp.org
  L'annonce officielle : http://googlewebmastercentral.blogspot.fr/2015/02/finding-more-mobile-friendly-search.html
  La page d'aide de google pour aider les webmaster à rendre leur site "mobile friendly" : https://developers.google.com/webmasters/mobile-sites/get-started/?utm_source=wmc-blog&utm_medium=referral&utm_campaign=mobile-friendly
    MUST SEE: https://developers.google.com/web/fundamentals/getting-started/
              https://developers.google.com/webmasters/mobile-sites/mobile-seo/?hl=fr
  Dans la presse française: http://www.lefigaro.fr/secteur/high-tech/2015/04/21/01007-20150421ARTFIG00199-google-declenche-un-mobilegeddon-en-changeant-l-ordre-de-ses-resultats.php
                            Google Search : soyez « mobile-friendly » ou déclassé: http://www.linformatique.org/google-search-soyez-mobile-friendly-ou-declasse/
  Cf. aussi la FAQ très intéressante : http://searchengineland.com/tomorrow-is-mobilegeddon-are-you-ready-for-the-google-mobile-friendly-update-219291
- Ajout d'un sitemap : https://support.google.com/webmasters/answer/156184
- Ajout de données structurées : https://www.google.com/webmasters/tools/structured-data?hl=fr&siteUrl=http://www.jdhp.org/&authuser=0
- Ajour de marqueurs de données : https://www.google.com/webmasters/tools/data-highlighter?hl=fr&siteUrl=http://www.jdhp.org/&authuser=0
- Inspiration pour le nouveau CSS:
    - http://makefly.depotoi.re/ (bar de menu simple mais efficace)
    - barre de menu et header des "profile settings" de gitlab (https://framagit.org/profile/): l'item courant est simplement souligné (simple et efficace)

## SEO

- https://developers.google.com/webmasters/mobile-sites/mobile-seo/common-mistakes/
- conseils de http://searchengineland.com : http://searchengineland.com/seotable

- https://www.google.com/webmasters/tools/home?hl=fr
  Bénéficiez de données, d'outils et de diagnostics pour un site sans erreurs et facilement explorable par Google. Voici quelques conseils :

      Vérifiez l'état de santé de votre site pour traiter les éventuels problèmes détectés par Google.
      Identifiez les tendances en termes de trafic issu de la recherche sur votre site et découvrez comment les internautes trouvent celui-ci.
      Optimisez votre site pour qu'il soit mieux analysé et représenté dans les résultats de recherche Google.

    Outils pour les webmasters
    Recommandée : Importer un fichier HTML Importez un fichier HTML sur votre site.
    1. Téléchargez ce fichier de validation HTML [googleddb024b403704a98.html] .
    2. Transférez le fichier vers http://www.jdhp.org/.
    3. Confirmez la réussite du transfert en accédant au site http://www.jdhp.org/googleddb024b403704a98.html dans votre navigateur.
    4. Cliquez sur "Valider" ci-dessous.
    Pour conserver votre statut de propriétaire confirmé, ne supprimez pas le fichier HTML, même une fois la validation effectuée.

## DEV

- ajouter un fichier .htaccess et corriger les erreurs 404 (cf. http://stats.tuxfamily.org/awstats.pl?config=jdhp.org&framename=mainright&output=errors404) avec des "permanent-redirect" dans le fichier .htaccess
x corriger les erreurs du W3C validator !
x check generated html == former version
- fix TODOs in xml files
* délimiter visuellement les liens :
  - underline uniquement quand on survole le lien (comme dans wikipedia, etc.)
  alt
      - soit avec un underligne discret (très clair) comme dans ../design_examples/genericons-demo.jpg (CSS3 only ou utiliser margin bottom pour CSS2) ou utiliser 
        http://stackoverflow.com/questions/12804419/css-text-decoration-underline-color
        http://stackoverflow.com/questions/12557707/changing-underline-color
      - soit en personalisant
        a:link {...}
        a:visited {...}
        a:hover {...}
        a:active {...}
        pour mettre en évidence le lien quand on le survole -> soit par l'apparition d'un underline, soit par une mise en gras, soit par un changement de couleur
        comme dans http://demo.studiopress.com/education/sample-post/
        cf. http://www.alsacreations.com/astuce/lire/43-comment-dfinir-lapparence-de-ses-liens.html pour la définition de link, visited, hover, active.
- genericons -> icons in css + svg (see genericons on google) + see ../design_examples/genericons-demo.jpg for design suggestion
x refaire les "notes" en haut de page (elle s'affichent mal sur smartphones et tablettes)
- ancres html -> sont-elles bien là pour chaque item ?
- fix/check schema/page.xsd
* galerie photo en Java Script quand il y a + d'une photo/vidéo sur un projet
  On appelle ça un "carousel"
  En mettre un qui défile automatiquement pour que les internautes voient qu'il y a plusieurs images...
  Chercher "carousel image open source"
  La pluspart sont écrit en Javascript/JQuery (http://fr.wikipedia.org/wiki/JQuery)
  http://designm.ag/inspiration/32-open-source-plugins-for-image-galleries-carousels/
  http://designshack.net/articles/freebies/weekly-freebies-25-awesome-free-jquery-image-sliders-and-carousels/
  http://www.jssor.com/
  http://mathieu-robin.developpez.com/tutoriels/javascript/creer-plugin-slideshow-pour-jquery/
- Générer une page html pour chaque items (projets) pour y mettre plus
  d'informations sans alourdir la page "projet_xx.html" (instructions pour Git,
  licence, plusieurs screenshots, plusieurs vidéos, ...). 
  => créer un css pour ces pages et écrire directement des pages html regroupées dans un même répertoire (./html/xxx_en.html), idem avec les pages générées avec hevea (latex).
  Ajouter un fil d'Ariane (police des liens de couleur bordeaux)
* vérif compatibilité avec IE et safari
- Web Analytics: add Piwik (the most famous Opensource Web Analytics) : http://piwik.org/

## Web 2.0

+ social networks (amélorer le référencement, avoir un retour)
  boutons "+1" google, "like" facebook, "in share" linkedin, "tweet" twitter, "dig" digger (?), ...
  Où ? -> sur la page d'accueil du site et pour chaque "ancre html" (ie chaque item: article, logiciel, tutoriel, ...)
  - https://developers.google.com/+/web/+1button/   and   https://developers.google.com/+/web/snippet/?hl=fr
  - https://developers.google.com/+/web/share/
  - https://support.google.com/plus/answer/3113301?p=plusone_posts&rd=1
  - https://about.twitter.com/resources/buttons
  - eg. http://apprendre-la-photo.fr/filtres-utiles-photo-numerique/
        http://www.ya-graphic.com/2011/03/bouton-plus-un-de-google/
* badges "follow me"/"suivre ce site": liens vers mon compte google+, facebook, twitter, linkedin, RSS, youtube, filcker, deviantart, stackoverflow, pinterest, instagram, reddit, github, vimeo, ...
  - https://developers.google.com/+/web/badge/
  - ...
  - eg. http://www.davidrevoy.com/, 
- commentaires avec Disqus (?) ou Juvia (?) ou Isso (http://posativ.org/isso/)
- blog (eg. Pelican) (bien définir son utilité) ?
+ amélorer le référencement du site (robot.txt, etc.)
  robot.txt, meta:description, sitmaps : http://en.wikipedia.org/wiki/Sitemaps, ...
  https://support.google.com/webmasters/topic/4581352?hl=fr&ref_topic=4581229
  http://www.ya-graphic.com/
+ ajouter des info (pro) sur mon profil google+

## CONTENT

* heberger le site web des projets de taille moyenne dans des sous domaines de
  jdhp.org (ex: pyarm.jdhp.org, vor12.jdhp.org, snippets.jdhp.org, ...).
  Suppose d'avoir un "espace web TuxFamily" par projet. Les projets de grande
  taille ont leur propre domaine (ex: ailib.org, pywi.org, botsim.org, ...),
  les autres (petits projets) ne sont pas mentionnés sur jdhp.org.
x CV: mettre des intervalles d'années plutot que la date d'obtention du diplome + ajouter "since 2012: PhD at Inria..."
x add mes articles scientifiques (+ poster esann) et mes présentations (dvs?, xcsf, ...)
x Sous le nom et sous "PhD student at Inria...", ajouter le domaine (computer science, Learning and Optimization) et l'intitulé de mon sujet de thèse
x remplacer "gitweb" par "browse source code"
x gitweb: afficher directement l'arbre plutôt que les commit -> append "?a=tree" à la fin de toutes les url
x jdhp sur LRI -> ajouter htaccess permanent redirect vers jdhp.org
x Git: ajouter automatiquement "Get source code (tarball)" -> génération auto = simplement l'url gitweb + "a=snapshot;h=HEAD;sf=tgz"
x add a bib file with my publications
* adopt a more "consensual" presentation of presentation like this one: http://jbobin.cosmostat.org/publications/
* remplacer "articles" par "academic papers"/"publications académiques" et "tutorials" par "autres documents" (trouver un meilleur titre) ?
* Reécrire la description du projet "pyarm" -> mentionner les articles, expliquer succintement avec des mots simples le principe (scientifique) et les résultats.
* Faire une unique vidéo de pyarm en 2 parties : "learning phase : ... (expliquer que les trajectoires sont calculées avec ...)" puis "generalization phase: (expliquer qu'on utilise le controleur appris ...)"
  -> pour le texte: police blanche sur fond noir (s'inspirer des vidéos de Phymec (Bullet Physics) avec transition douce
  -> apprendre à créer des vidéos HD (720p) de qualité sur youtube (voir même full HD si possible)...
     https://support.google.com/youtube/answer/1722171?hl=en
     https://productforums.google.com/forum/#!topic/youtube/LMN2pL2oNIs
* HeVeA: modifier le CSS (s'inspirer de https://scaron.info/doc/intro-arbres-decision/) et régler le pb avec les images + ajouter une cible "hevea" dans les makefiles (nottament dans les snippets LaTeX) -> cf. http://hevea.inria.fr/doc/manual002.html
* Ajouter compte Github sur la page d'accueil
* ajouter des mini tuto en IA -> 1 document = 1 algo (contexte + algo + explications + exemple d'implémentation python) => rester simple et concis => une sorte de snippet appliquée algos (traite d'un sujet précis)
  "tutorial.tex" (enrobage document, meta, packages, etc.) + "saes.tex" (contenu réutilisable dans des articles)
  faire en parallèle des vrais articles qui réutilisent ces "snippets" (include fichier .tex)
* Ajouter/commiter les snippets suivants:
    Référencés sur le site:
    + OpenCV Python
    + Arduino
    + Design patterns en C++ et Java
    cairo (C)
    sdl (C)
    XSD
    Xquery
    CSS
    DOM

    Non-référencés sur le site (ie. à ajouter dans les pages web):
    * curses (python)
    * ant
    + bash
    + Graphviz
    awk
    opengl
    sqlite
    sql (avec sqlite mais centré sur les requetes sql)
    - autotools
    gcov (?)/gprof (?)
    xpath
    php
* CV: mettre un CV un peu plus complet en html -> utiliser h2/h3 pour délimiter Formation/Enseignements/Expérience professionnelle/...
* Ajouter "Full CV" sur la page d'accueil en PDF (sans numéro de tel, email, adresse postale et activités perso)
* finir de mettre à jour la partie "snippets", la mettre plus en évidence
* snippets: mettre liens à la racine pour ant, make, javascript, xml, ...
* snippets: nettoyer le répertoire "programmation avr"
+ ajouter lien vers facebook
+ déposer une appli android dans google play + ajouter un lien vers mon compte google play
+ publier un article dans linux mag
+ faire en sorte qu'un de mes logiciels soit accepté dans les dépots officiels Debian
+ ajouter les articles suivants:
           ~/Documents/master_IAD/M2_IAD_2010/M2S4v2_stage/ISIR/rapport_et_presentation
           ~/Documents/isir/rapport_et_presentation
           ~/Documents/isir/rapport_et_presentation_11.tar.gz
           ~/Documents/cours_anglais/exposé/  (opensource society)
           document FTP
+ ajouter tutos suivant: make, kicad/geda + fabrication pcb, openscad + slic3r + witbox, blinkled avr with avr-gcc, iptables + initsys5/upstart, tcpwrappers, outils shell cookbook (sed, grep, find, awk, ...), outils shell pour la programmation (nm, ldd, ...), programmation system C (cf. cours), programmation avr, programmation gpio rpi, boutton on/off rpi, vim cookbook (+ vimrc), vim + screen
+ mentionner mes enseignements + ajouter les ressources que j'ai créé + jeu de nim
- ajouter la date de publication des items (ça change quoi côté ergonomie ?)
  pour les articles et les tutos seulement ? la date de quoi exactement
  (rédaction, publication sur jdhp, publication externe pour les articles
  académiques, ... -> à expliciter sur le site) ?
- Ajouter l'emprunte de ma clé GPG dans la page "home_**.html" et l'utiliser
  pour signer les paquets et le dépôt Debian.
+ attribut "license" non renseignés/affichés
+ comment mettre à jours automatiquement les packages debian (via les makefiles comme pour les articles), images, thumbnails, ...
+ UTF-8 -> passe bien sur windows ?
+ ajouter l'adresse du labo
+ add pdf_presenter
+ add systool_exif and audio_tag_py
+ add le code C utilsé pour créer un graph de dépendances dynamique
+ add piclockradio + screen on/off
+ add netfilter scripts ?
x maj les archives (clonefinder par exemple)
+ add vim config ?
+ scripts dual screen ?
+ mini howto / mementos à thème (bash, python, etc.) faits à partir des questions opencal (utile pour prouver le CV) Latex/PDF + version HTML
+ article pour setup Raspbian (post install script)
+ ajouter fichier openscad sur les plateformes de partages d'objets 3d... (+ lien vers ces pages)
+ add iptables scripts (firewall skills)
+ ajouter photos d'art
+ poster des articles sur le site RPi
- add image rating (script python pyqt pour faire le tri dans les photos)
- nettoyer: botsim, libdynamixel, pydinamixel, binviewer, pypong, dtools
- add ia articles + codes
- botsim/openscenegraph/bullet: screencast, antialiasing
- add robotics/arduino (3pi, assuro, ...) + article about the toolchain
- add android (qqch de simple; bus timetable)
- add opclite...
- add corpus ?
- add my reading list (like http://www.cs.utexas.edu/~shivaram/readings/res-cat-5.html)
- HTML5-canvas / Javascript / CSS3 demos for AI (MDP, minimax, ...)
