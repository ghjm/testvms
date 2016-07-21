#!/bin/bash
read -p "Delete all test-* VMs and rebuild from scratch? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    rm -rf Virtual\ Machines/test-*
    ./build_snapshot_shutdown.yml -l test-* --ask-vault-pass -e serial=4
fi
