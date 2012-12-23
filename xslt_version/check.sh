#!/bin/sh

echo "Check page.xsd syntax..."
xmllint --noout schemas/page.xsd

echo "Check page.xsd DTD validity..."
xmllint --noout --valid schemas/page.xsd

echo "Check page.xsd schema validity..."
xmllint --noout --schema schemas/XMLSchema.xsd schemas/page.xsd

echo "Check articles.xml..."
xmllint --noout --schema schemas/page.xsd articles.xml

echo "Check projects.xml..."
xmllint --noout --schema schemas/page.xsd projects.xml

echo "Check tutorials.xml..."
xmllint --noout --schema schemas/page.xsd tutorials.xml
