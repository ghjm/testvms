#!/bin/bash

DIR=$(dirname "$0")
. $DIR/get_cmdline.sh

if [ -z "$ANSIBLE_VAULT_PASSWORD_FILE" ]; then
  AVP="--ask-vault-pass"
else
  AVP=""
fi
$DIR/site.yml -l "$LIMIT" $AVP -e serial=4 ${RESNAP:+"-e resnap=$RESNAP"}
