#!/bin/bash

while getopts ":nl:" opt; do
    case $opt in
        l)
            if [ -z "$LIMIT" ]; then
                LIMIT=$OPTARG
            else
                LIMIT=$LIMIT,$OPTARG
            fi
            ;;
        n)
            RESNAP=0
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
RESNAP=${RESNAP:-1}
