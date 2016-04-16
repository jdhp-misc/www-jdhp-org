#!/bin/sh

if [ -z ${JDHP_ROOT_PATH} ] || [ \! -d ${JDHP_ROOT_PATH} ]
then
    echo "ERROR: the JDHP_ROOT_PATH environment variable is not set or not valid."
    exit 1
fi

IMG_INPUT_DIR=${JDHP_ROOT_PATH}/download.tuxfamily.org/image
MOV_INPUT_DIR=${JDHP_ROOT_PATH}/download.tuxfamily.org/video
OUTPUT_DIR=${JDHP_ROOT_PATH}/www.jdhp.org/medias/thumbnails
LOGO_FILE=${JDHP_ROOT_PATH}/www.jdhp.org/medias/images/video.png

# MAKE THUMBNAILS (SCREENSHOT) ################################################

echo "Génère les thumbnails (screenshot)"
mogrify -format png -path ${OUTPUT_DIR}/ -thumbnail 80x80 ${IMG_INPUT_DIR}/*.png
mogrify -format png -path ${OUTPUT_DIR}/ -thumbnail 80x80 ${IMG_INPUT_DIR}/*.jpeg

# MAKE THUMBNAILS (VIDEOS) ####################################################

echo "Génère les thumbnails (videos)"
for VIDEO_PATH in ${MOV_INPUT_DIR}/*.ogv
do
    VIDEO_FILE=$(basename ${VIDEO_PATH}  | sed -r "s/(.+)\.ogv/\1/g")

    #ffmpeg -y -i ${VIDEO_PATH} -f mjpeg -ss 1 -vframes 1 -s 80x80 -an ${OUTPUT_DIR}/${VIDEO_FILE}.jpeg

    # FFMPEG doesn't exist in Debian -> use avconv instead (FFMPEG fork)
    avconv -y -i ${VIDEO_PATH} -f mjpeg -ss 1 -vframes 1 -s 80x80 -an ${OUTPUT_DIR}/${VIDEO_FILE}.jpeg

    composite -gravity center ${LOGO_FILE} ${OUTPUT_DIR}/${VIDEO_FILE}.jpeg ${OUTPUT_DIR}/${VIDEO_FILE}.png

    rm -v ${OUTPUT_DIR}/${VIDEO_FILE}.jpeg
done

# APPLY THE "POLAROID" EFFECT #################################################

# http://www.imagemagick.org/Usage/thumbnails/

for FILE in ${OUTPUT_DIR}/*.png
do
    convert ${FILE} -bordercolor snow -background black +polaroid ${FILE}
done
