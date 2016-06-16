#!/bin/bash

# Exit on error
set -e

# Allocate params
URL=$(cat config.params | grep URL | awk -F\= '{print $2}')
PKG_NAME=$(cat config.params | grep PKG_NAME | awk -F\= '{print $2}')
VERSION=$(cat config.params | grep VERSION | awk -F\= '{print $2}')
ROOTDIR=$(cat config.params | grep ROOTDIR | awk -F\= '{print $2}')
DESCRIPTION=$(cat config.params | grep DESCRIPTION | awk -F\= '{print $2}')

if [ -z "${URL}" ]; then
    echo "No URL given to fecth the archive"
    exit 1
fi

if [ -z "${PKG_NAME}" ]; then
    echo "No PKG_NAME provides"
    exit 1
fi

if [ -z "${VERSION}" ]; then
    echo "No VERSION provides"
    exit 1
fi

if [ -z "${ROOTDIR}" ]; then
    echo "No ROOTDIR provides"
    exit 1
fi

# Retreive and extract archive
if [ ! -d ${ROOTDIR}/${PKG_NAME} ]; then
  mkdir -p ${ROOTDIR}/${PKG_NAME}
fi

tmpdir=$(mktemp -d)
mkdir -p ${tmpdir}
cd ${tmpdir}
wget --no-check-certificate --no-cookies  ${URL}
tar zxvf *  -C ${ROOTDIR}/${PKG_NAME} --strip-components=1


# Create the package
fpm -s dir -t deb -n "${PKG_NAME}" --description "${DESCRIPTION}" -v $VERSION -p /dist ${ROOTDIR}/${PKG_NAME}

exit 0
