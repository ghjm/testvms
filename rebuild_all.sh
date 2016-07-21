#!/bin/bash
read -p "Delete all test-* VMs and rebuild from scratch? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf Virtual\ Machines/test-*
    ./site.yml -l test-* --ask-vault-pass -e serial=4 -e bssd=1
fi
