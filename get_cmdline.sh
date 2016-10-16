#!/bin/bash

while getopts ":rl:" opt; do
    case $opt in
        l)
            if [ -z "$LIMIT" ]; then
                LIMIT=$OPTARG
            else
                LIMIT=$LIMIT,$OPTARG
            fi
            ;;
        r)
            RESNAP=1
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
