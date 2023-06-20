#!/bin/bash

usage() { echo "Usage:
$0 [-o <owner_name>]
$0 [-m <creation_month>]" 1>&2; exit 1; }

displayFileLineCount() { echo "File: $1, $(wc -l < "$1") lines"; }

getopts ":o:m:" r

case "${r}" in
    o)
        echo "Looking for files where the owner is: ${OPTARG}"

        for file in $(find -type f -user ${OPTARG}); do
            displayFileLineCount $file
	done
        ;;
    m)
        echo "Looking for files where the month is: ${OPTARG}"

        for file in $(find -type f); do
            if [[ $(ls -l $file | awk '{print $6}') = ${OPTARG} ]]; then
                displayFileLineCount $file
            fi
        done
        ;;
    *)
        usage
        ;;
esac


