#!/bin/sh

if [ -z ${JDHP_ROOT_PATH} ] || [ \! -d ${JDHP_ROOT_PATH} ]
then
    echo "ERROR: the JDHP_ROOT_PATH environment variable is not set or not valid."
    exit 1
fi

if [ -d ${JDHP_ROOT_PATH}/www.jdhp.org/www ]
then
    rm -rv ${JDHP_ROOT_PATH}/www.jdhp.org/www
fi
