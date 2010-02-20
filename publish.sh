#!/bin/sh

############################################################################
# Publie sur le web la dernière version enregistrée sur le référentiel SVN #
############################################################################

JDHP_LOCAL_PATH=/tmp/jdhp.org
BASE_DEFAULT="<base href\=\"http:\/\/127\.0\.0\.1\/jdhp\.org\/\" \/>"
BASE_ONLINE="<base href\=\"http:\/\/www\.jdhp\.org\/\" \/>"
DEFAULT_LANG=fr

# Vide le répertoire cible de l'export
echo "Vide le répertoire cible de l'export"
rm -rf $JDHP_LOCAL_PATH

# Exporte le site depuis Git
echo "Exporte le site depuis Git"
git clone . $JDHP_LOCAL_PATH

# Crée le fichier index (suivant la langue par défaut)
cp $JDHP_LOCAL_PATH/www/index_$DEFAULT_LANG.html $JDHP_LOCAL_PATH/www/index.html

# Définition de la balise <base /> source et de la balise <base /> destination
echo "Modification des balises HTML <base>"
find $JDHP_LOCAL_PATH/www/ -type f -name "*.html" -exec sed -i "s/$BASE_DEFAULT/$BASE_ONLINE/g" "{}" \;

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

# Corrige les permissions si besoin
echo "Corrige les permissions"
find $JDHP_LOCAL_PATH/www/ -type f -exec chmod -v 444 {} \;
find $JDHP_LOCAL_PATH/www/ -type d -exec chmod -v 555 {} \;

# Uploade les fichiers avec rsync
clear
echo -n "Les fichiers sont sur le point d'être chargés sur le serveur web distant. Les ports de communication appropriés doivent être ouverts pour rsync et ssh. Êtes-vous sur de vouloir continuer ? (oui/non) : "
read upload
if [ "$upload" = "oui" ]
then
	rsync -a -v -e ssh $JDHP_LOCAL_PATH/www/ gremy@ssh.tuxfamily.org:/home/jdhp/jdhp.org-web/htdocs/
fi

# Rétabli les permissions pour la suppression des fichiers
find $JDHP_LOCAL_PATH/www/ -type f -exec chmod 666 {} \;
find $JDHP_LOCAL_PATH/www/ -type d -exec chmod 777 {} \;

# Supprime le répertoire
echo "Suppression du réperoire local"
rm -rf $JDHP_LOCAL_PATH
