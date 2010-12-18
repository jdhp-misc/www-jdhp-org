#!/bin/sh

############################################################################
# Publie sur le web la dernière version enregistrée sur le référentiel SVN #
############################################################################

JDHP_SRC_PATH=.
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
cp -r $JDHP_SRC_PATH/files $JDHP_LOCAL_PATH

# Crée le fichier index (suivant la langue par défaut)
cp $JDHP_LOCAL_PATH/www/index_$DEFAULT_LANG.html $JDHP_LOCAL_PATH/www/index.html

# Définition de la balise <base /> source et de la balise <base /> destination
echo "Modification des balises HTML <base>"
find $JDHP_LOCAL_PATH/www/ -type f -name "*.html" -exec sed -i "s/$BASE_DEFAULT/$BASE_ONLINE/g" "{}" \;

# Génère les thumbnails (imagemagick et ffmpeg)
echo "Génère les thumbnails (screenshot)"
mkdir -p $JDHP_LOCAL_PATH/www/medias/thumbnails/screenshots/
mogrify -format png -path $JDHP_LOCAL_PATH/www/medias/thumbnails/screenshots/ -thumbnail 80x80 $JDHP_LOCAL_PATH/files/medias/images/screenshots/*.png

echo "Génère les thumbnails (videos)"
mkdir -p $JDHP_LOCAL_PATH/www/medias/thumbnails/videos/
for VIDEO_PATH in $JDHP_LOCAL_PATH/files/medias/videos/*.ogv
do
    VIDEO_FILE=$(basename $VIDEO_PATH  | sed -r "s/(.+)\.ogv/\1/g")
    ffmpeg -y -i $VIDEO_PATH -f mjpeg -ss 1 -vframes 1 -s 80x80 -an $JDHP_LOCAL_PATH/www/medias/thumbnails/videos/$VIDEO_FILE.jpeg
    composite -gravity center $JDHP_LOCAL_PATH/www/medias/images/video.png $JDHP_LOCAL_PATH/www/medias/thumbnails/videos/$VIDEO_FILE.jpeg $JDHP_LOCAL_PATH/www/medias/thumbnails/videos/$VIDEO_FILE.png
done

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
	rsync -a -v -e ssh --delete $JDHP_LOCAL_PATH/www/ gremy@ssh.tuxfamily.org:/home/jdhp/jdhp.org-web/htdocs/
fi

# Rétabli les permissions pour la suppression des fichiers
find $JDHP_LOCAL_PATH/www/ -type f -exec chmod 666 {} \;
find $JDHP_LOCAL_PATH/www/ -type d -exec chmod 777 {} \;

# Supprime le répertoire
echo "Suppression du réperoire local"
rm -rf $JDHP_LOCAL_PATH
