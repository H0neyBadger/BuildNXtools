#!/bin/bash 
set -euo pipefail

usage()
{  

    echo "Dummy script to replace RequiredSystemVersion from NSP files"
    echo "Usage: $0 ./file.nsp ./dest.nsp"
    exit 1  
} 

if [ $# -ne 2 ] ; then
    usage
else
    filename=$1
    dest=$2
fi

if [ ! -f "$filename" ]; then
    echo "File '$filename' not found!"
    usage
fi

if [ -f "$dest" ]; then
    echo "Destination file '$dest' already exists!"
    usage
fi


sed 's;<RequiredSystemVersion>.*</RequiredSystemVersion>;<RequiredSystemVersion>000000000</RequiredSystemVersion>;g' \
    "${filename}" | tee -i "${dest}" | strings | grep SystemVersion
