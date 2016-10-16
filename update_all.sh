#!/bin/bash

DIR=$(dirname "$0")
. $DIR/get_cmdline.sh

$DIR/site.yml -l "$LIMIT" --ask-vault-pass -e serial=4 ${RESNAP:+"-e resnap=$RESNAP"}
