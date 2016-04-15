#!/bin/sh

JDHP_ROOT_PATH=~/jdhp/www.jdhp.org

echo "Check page.xsd syntax..."
xmllint --noout ${JDHP_ROOT_PATH}/schemas/page.xsd

echo 
echo "Check page.xsd DTD validity..."
xmllint --noout --valid ${JDHP_ROOT_PATH}/schemas/page.xsd

#echo 
#echo "Check page.xsd schema validity..."
#xmllint --noout --schema ${JDHP_ROOT_PATH}/schemas/XMLSchema.xsd schemas/page.xsd

for FILE in ${JDHP_ROOT_PATH}/*.xml
do
    echo 
    echo "Check $FILE..."
    xmllint --noout --schema ${JDHP_ROOT_PATH}/schemas/page.xsd $FILE
done

