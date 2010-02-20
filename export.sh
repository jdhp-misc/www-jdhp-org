#!/bin/sh

###############################
# Export the curent workspace #
###############################

JDHP_SRC_PATH=.
JDHP_LOCAL_PATH=/tmp/jdhp.org
BASE_DEFAULT="<base href\=\"http:\/\/127\.0\.0\.1\/jdhp\.org\/\" \/>"
BASE_FILE="<base href\=\"file:\/\/\/tmp\/jdhp\.org\/www\/\" \/>"
DEFAULT_LANG=fr

# Vide le répertoire cible de l'export
echo "Vide le répertoire cible de l'export"
rm -rf $JDHP_LOCAL_PATH

# Exporte le site
echo "Exporte le site depuis l'espace de travail courant"
mkdir $JDHP_LOCAL_PATH
cp -r $JDHP_SRC_PATH/ $JDHP_LOCAL_PATH

# Crée le fichier index (suivant la langue par défaut)
cp $JDHP_LOCAL_PATH/www/index_$DEFAULT_LANG.html $JDHP_LOCAL_PATH/www/index.html

# Définition de la balise <base /> source et de la balise <base /> destination
echo "Modification des balises HTML <base>"
find $JDHP_LOCAL_PATH/www/ -type f -name "*.html" -execdir sed -i "s/$BASE_DEFAULT/$BASE_FILE/g" "{}" \;

# Génère les thumbnails (image magick)
echo "Génère les thumbnails"
mkdir -p $JDHP_LOCAL_PATH/www/medias/thumbnails/screenshots/
mogrify -format png -path $JDHP_LOCAL_PATH/www/medias/thumbnails/screenshots/ -thumbnail 80x80 $JDHP_LOCAL_PATH/www/medias/screenshots/*.png

# Compile les fichiers tex
echo "Compile les fichiers tex"
find $JDHP_LOCAL_PATH/www/articles -name "Makefile" -execdir make \;
find $JDHP_LOCAL_PATH/www/tutorials -name "Makefile" -execdir make \;

# Supprime les fichiers intermédiaires utilisés lors de la compilation des fichiers Tex
echo "Supprime les fichiers intermédiaires utilisés lors de la compilation des fichiers Tex"
find $JDHP_LOCAL_PATH/www/articles -name "Makefile" -execdir make clean \;
find $JDHP_LOCAL_PATH/www/tutorials -name "Makefile" -execdir make clean \;

find $JDHP_LOCAL_PATH/www/articles -name "Makefile" -execdir rm {} \;
find $JDHP_LOCAL_PATH/www/tutorials -name "Makefile" -execdir rm {} \;

firefox $JDHP_LOCAL_PATH/www/index.html &
