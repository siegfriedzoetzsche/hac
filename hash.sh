#!/usr/bin/env bash
{

    directories=$(find . -mindepth 1 -maxdepth 1 -type d)

    if [ ! $# -eq 0 ]; then
        directories=$@
    fi

    if [ -z "${directories}" ]; then
        echo "No directories found."
        exit
    else
        for dir in ${directories}; do
            if [ ! -d ${dir} ]; then
                echo "'${dir}' is not a directory: skipping."
                continue
            fi
            if [ ! -z $(find ${dir} -maxdepth 0 -empty) ]; then
                echo "'${dir}' is empty: skipping."
                continue
            fi
            echo "Writing checksums for '${dir}' to '${dir}.sha1sum' ..."
	    find ${dir} -type f -print0 | xargs -0 sha1sum > /tmp/${dir}.sha1sum; mv /tmp/${dir}.sha1sum .
            echo "done."
        done
    fi
    
}; exit
