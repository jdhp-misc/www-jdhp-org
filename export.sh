#!/bin/sh

###############################
# Export the curent workspace #
###############################

JDHP_SRC_PATH=.
JDHP_LOCAL_PATH=/tmp/jdhp.org

# VIDE LE RÉPERTOIRE CIBLE DE L'EXPORT
echo "Vide le répertoire cible de l'export"
rm -rf $JDHP_LOCAL_PATH

# EXPORTE LE SITE
echo "Exporte le site depuis l'espace de travail courant"
mkdir $JDHP_LOCAL_PATH
cp -r $JDHP_SRC_PATH/ $JDHP_LOCAL_PATH

# COMPILE...
CUR_DIR=`pwd`
cd $JDHP_LOCAL_PATH
./parser.py -b "$JDHP_LOCAL_PATH"
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

firefox $JDHP_LOCAL_PATH/www/index.html &
