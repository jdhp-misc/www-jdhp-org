#!/bin/sh

echo "Check page.xsd syntax..."
xmllint --noout schemas/page.xsd

echo 
echo "Check page.xsd DTD validity..."
xmllint --noout --valid schemas/page.xsd

#echo 
#echo "Check page.xsd schema validity..."
#xmllint --noout --schema schemas/XMLSchema.xsd schemas/page.xsd

for FILE in home_en.xml  home_fr.xml  articles_en.xml  articles_fr.xml  common_en.xml  common_fr.xml  common.xml  projects_en.xml  projects_fr.xml  tutorials_en.xml  tutorials_fr.xml
do
    echo 
    echo "Check $FILE..."
    xmllint --noout --schema schemas/page.xsd $FILE
done

