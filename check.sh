#!/usr/bin/env bash
{

    checksum_files=$(find . -maxdepth 1 -type f -name "*.sha1sum")
    directories=$(find . -mindepth 1 -maxdepth 1 -type d)

    echo "Checking for directories without corresponding checksum file '<DIRNAME>.sha1sum' ..."
    for dir in ${directories}; do
        if [ ! -f ${dir}.sha1sum ]; then
            echo "Warning: found directory '${dir}' but no checksum file '${dir}.sha1sum'."
        fi
    done
    echo "done."
    
    if [ ! $# -eq 0 ]; then
        checksum_files=$@
    fi

    if [ -z "${checksum_files}" ]; then
        echo "No checksum files found."
        exit
    else
        exitcode=0
        for checksum_file in ${checksum_files}; do
            echo "Checking '${checksum_file}' ..."
            sha1sum -c --quiet ${checksum_file}
            exitcode=$((${exitcode} + $?))
            if [ ${exitcode} -eq 0 ]; then
                echo "OK!"
            else
                echo "'${checksum_file}': Something is wrong!"
            fi
        done
        if [ ${exitcode} -eq 0 ]; then
            echo "Everything is fine!"
        else
            echo "Something is wrong!"
        fi
    fi
    
}; exit
