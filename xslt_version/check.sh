#!/bin/sh

echo "Check page.xsd syntax..."
xmllint --noout page.xsd

echo "Check page.xsd DTD validity..."
xmllint --noout --valid page.xsd

echo "Check page.xsd schema validity..."
xmllint --noout --schema XMLSchema.xsd page.xsd

echo "Check articles.xml..."
xmllint --noout --schema page.xsd articles.xml

echo "Check projects.xml..."
xmllint --noout --schema page.xsd projects.xml

echo "Check tutorials.xml..."
xmllint --noout --schema page.xsd tutorials.xml
