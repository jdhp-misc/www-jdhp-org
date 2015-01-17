#!/bin/sh

IMG_INPUT_DIR=../files/image
MOV_INPUT_DIR=../files/video
OUTPUT_DIR=medias/thumbnails
LOGO_FILE=medias/images/video.png

# MAKE THUMBNAILS (SCREENSHOT)

echo "Génère les thumbnails (screenshot)"
mogrify -format png -path ${OUTPUT_DIR}/ -thumbnail 80x80 ${IMG_INPUT_DIR}/*.png
mogrify -format png -path ${OUTPUT_DIR}/ -thumbnail 80x80 ${IMG_INPUT_DIR}/*.jpeg


# MAKE THUMBNAILS (VIDEOS)

echo "Génère les thumbnails (videos)"
for VIDEO_PATH in ${MOV_INPUT_DIR}/*.ogv
do
    VIDEO_FILE=$(basename ${VIDEO_PATH}  | sed -r "s/(.+)\.ogv/\1/g")

    #ffmpeg -y -i ${VIDEO_PATH} -f mjpeg -ss 1 -vframes 1 -s 80x80 -an ${OUTPUT_DIR}/${VIDEO_FILE}.jpeg

    # FFMPEG doesn't exist in Debian -> use avconv instead (FFMPEG fork)
    avconv -y -i ${VIDEO_PATH} -f mjpeg -ss 1 -vframes 1 -s 80x80 -an ${OUTPUT_DIR}/${VIDEO_FILE}.jpeg

    composite -gravity center ${LOGO_FILE} ${OUTPUT_DIR}/${VIDEO_FILE}.jpeg ${OUTPUT_DIR}/${VIDEO_FILE}.png
done
