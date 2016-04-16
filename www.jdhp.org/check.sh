#!/bin/sh

if [ -z ${JDHP_ROOT_PATH} ] || [ \! -d ${JDHP_ROOT_PATH} ]
then
    echo "ERROR: the JDHP_ROOT_PATH environment variable is not set or not valid."
    exit 1
fi

echo "Check page.xsd syntax..."
xmllint --noout ${JDHP_ROOT_PATH}/www.jdhp.org/schemas/page.xsd

echo 
echo "Check page.xsd DTD validity..."
xmllint --noout --valid ${JDHP_ROOT_PATH}/www.jdhp.org/schemas/page.xsd

#echo 
#echo "Check page.xsd schema validity..."
#xmllint --noout --schema ${JDHP_ROOT_PATH}/www.jdhp.org/schemas/XMLSchema.xsd schemas/page.xsd

for FILE in ${JDHP_ROOT_PATH}/www.jdhp.org/*.xml
do
    echo 
    echo "Check $FILE..."
    xmllint --noout --schema ${JDHP_ROOT_PATH}/www.jdhp.org/schemas/page.xsd $FILE
done

