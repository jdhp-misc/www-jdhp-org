#!/bin/sh

###############################
# Export the curent workspace #
###############################

JDHP_SRC_PATH=/media/data/gremy/developpement_logiciel/workspaces/svn/projet_0068_jdhp/trunk/www
JDHP_LOCAL_PATH=/home/gremy/jdhp.org
BASE_DEFAULT="<base href\=\"http:\/\/127\.0\.0\.1\/jdhp\.org\/\" \/>"
BASE_FILE="<base href\=\"file:\/\/\/home\/gremy\/jdhp\.org\/www\/\" \/>"

# Vide le répertoire cible de l'export
echo "Vide le répertoire cible de l'export"
rm -rf $JDHP_LOCAL_PATH

# Exporte le site
echo "Exporte le site depuis l'espace de travail courant"
mkdir $JDHP_LOCAL_PATH
cp -r $JDHP_SRC_PATH/ $JDHP_LOCAL_PATH
find $JDHP_LOCAL_PATH/ -type d -name ".svn" -execdir rm -rf "{}" \;

# Définition de la balise <base /> source et de la balise <base /> destination
echo "Modification des balises HTML <base>"
find $JDHP_LOCAL_PATH/www/ -type f -name "*.html" -execdir sed -i "s/$BASE_DEFAULT/$BASE_FILE/g" "{}" \;

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

