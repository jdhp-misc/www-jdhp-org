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

# Génère les thumbnails (imagemagick et ffmpeg)
echo "Génère les thumbnails (screenshot)"
mkdir -p $JDHP_LOCAL_PATH/www/medias/thumbnails/screenshots/
mogrify -format png -path $JDHP_LOCAL_PATH/www/medias/thumbnails/screenshots/ -thumbnail 80x80 $JDHP_LOCAL_PATH/www/medias/screenshots/*.png

echo "Génère les thumbnails (videos)"
mkdir -p $JDHP_LOCAL_PATH/www/medias/thumbnails/videos/
for VIDEO_PATH in $JDHP_LOCAL_PATH/www/medias/videos/*.ogv
do
    VIDEO_FILE=$(basename $VIDEO_PATH  | sed -r "s/(.+)\.ogv/\1/g")
    ffmpeg -y -i $VIDEO_PATH -f mjpeg -ss 1 -vframes 1 -s 80x80 -an $JDHP_LOCAL_PATH/www/medias/thumbnails/videos/$VIDEO_FILE.jpeg
    composite -gravity center $JDHP_LOCAL_PATH/www/medias/images/video.png $JDHP_LOCAL_PATH/www/medias/thumbnails/videos/$VIDEO_FILE.jpeg $JDHP_LOCAL_PATH/www/medias/thumbnails/videos/$VIDEO_FILE.png
done

# Compile les fichiers Tex et les programmes
echo "Compile les fichiers Tex et les programmes"
find $JDHP_LOCAL_PATH/www/articles  -name "Makefile" -execdir make \;
find $JDHP_LOCAL_PATH/www/tutorials -name "Makefile" -execdir make \;
find $JDHP_LOCAL_PATH/www/projects  -name "Makefile" -execdir make \;

# Supprime les fichiers intermédiaires utilisés lors de la compilation des fichiers Tex et des programmes
echo "Supprime les fichiers intermédiaires utilisés lors de la compilation des fichiers Tex et des programmes"
find $JDHP_LOCAL_PATH/www/articles  -name "Makefile" -execdir make clean \;
find $JDHP_LOCAL_PATH/www/tutorials -name "Makefile" -execdir make clean \;
find $JDHP_LOCAL_PATH/www/projects  -name "Makefile" -execdir make clean \;

find $JDHP_LOCAL_PATH/www/articles  -name "Makefile" -execdir rm {} \;
find $JDHP_LOCAL_PATH/www/tutorials -name "Makefile" -execdir rm {} \;
find $JDHP_LOCAL_PATH/www/projects  -name "Makefile" -execdir rm {} \;

firefox $JDHP_LOCAL_PATH/www/index.html &
