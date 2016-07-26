#!/bin/bash

while getopts ":l:" opt; do
    case $opt in
        l)
            if [ -z "$LIMIT" ]; then
                LIMIT=$OPTARG
            else
                LIMIT=$LIMIT,$OPTARG
            fi
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
        :)
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

LIMIT=${LIMIT:-'test-*'}
