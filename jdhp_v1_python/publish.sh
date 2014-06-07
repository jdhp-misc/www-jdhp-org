#!/bin/sh

############################################################################
# Publie sur le web la dernière version enregistrée sur le référentiel SVN #
############################################################################

JDHP_SRC_PATH=.
JDHP_LOCAL_PATH=/tmp/jdhp.org

# VIDE LE RÉPERTOIRE CIBLE DE L'EXPORT
echo "Vide le répertoire cible de l'export"
rm -rf $JDHP_LOCAL_PATH

# EXPORTE LE SITE DEPUIS GIT
echo "Exporte le site depuis Git"
git clone . $JDHP_LOCAL_PATH
cp -r $JDHP_SRC_PATH/files $JDHP_LOCAL_PATH

# COMPILE...
CUR_DIR=`pwd`
cd $JDHP_LOCAL_PATH
./parser.py -b "http://www.jdhp.org/"
cd $CUR_DIR

# GÉNÈRE LES THUMBNAILS (IMAGEMAGICK ET FFMPEG)
mkdir -p $JDHP_LOCAL_PATH/www/medias/thumbnails/

echo "Génère les thumbnails (screenshot)"
mogrify -format png -path $JDHP_LOCAL_PATH/www/medias/thumbnails/ -thumbnail 80x80 $JDHP_LOCAL_PATH/files/image/*.png

echo "Génère les thumbnails (videos)"
for VIDEO_PATH in $JDHP_LOCAL_PATH/files/video/*.ogv
do
    VIDEO_FILE=$(basename $VIDEO_PATH  | sed -r "s/(.+)\.ogv/\1/g")
    ffmpeg -y -i $VIDEO_PATH -f mjpeg -ss 1 -vframes 1 -s 80x80 -an $JDHP_LOCAL_PATH/www/medias/thumbnails/$VIDEO_FILE.jpeg
    composite -gravity center $JDHP_LOCAL_PATH/www/medias/images/video.png $JDHP_LOCAL_PATH/www/medias/thumbnails/$VIDEO_FILE.jpeg $JDHP_LOCAL_PATH/www/medias/thumbnails/$VIDEO_FILE.png
done

# CORRIGE LES PERMISSIONS SI BESOIN
echo "Corrige les permissions"
find $JDHP_LOCAL_PATH/www/ -type f -exec chmod -v 444 {} \;
find $JDHP_LOCAL_PATH/www/ -type d -exec chmod -v 555 {} \;

# UPLOADE LES FICHIERS AVEC RSYNC
clear
echo -n "Les fichiers sont sur le point d'être chargés sur le serveur web distant. Les ports de communication appropriés doivent être ouverts pour rsync et ssh. Êtes-vous sur de vouloir continuer ? (oui/non) : "
read upload
if [ "$upload" = "oui" ]
then
	rsync -a -v -e ssh --delete $JDHP_LOCAL_PATH/www/ gremy@ssh.tuxfamily.org:/home/jdhp/jdhp.org-web/htdocs/
fi

# RÉTABLI LES PERMISSIONS POUR LA SUPPRESSION DES FICHIERS
find $JDHP_LOCAL_PATH/www/ -type f -exec chmod 666 {} \;
find $JDHP_LOCAL_PATH/www/ -type d -exec chmod 777 {} \;

# SUPPRIME LE RÉPERTOIRE
echo "Suppression du réperoire local"
rm -rf $JDHP_LOCAL_PATH
