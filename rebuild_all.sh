#!/bin/bash

DIR=$(dirname "$0")
. $DIR/get_cmdline.sh

(
  cd $DIR/Virtual\ Machines
  IFS=,
  FILES=$(ls -d $LIMIT 2>/dev/null)
  if [ $? -eq 0 ]; then
    echo The following virtual machines will be deleted:
    echo $FILES
  else
    echo No existing virtual machines match the limit. Nothing will be deleted.
  fi
)

read -p "Proceed (Y/N)? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    (
      cd $DIR/Virtual\ Machines
      IFS=,
      rm -rf $LIMIT
    )
    $DIR/update_all.sh "$@"
fi
