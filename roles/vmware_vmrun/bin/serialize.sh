#!/bin/bash

LOCKFILE=~/.lockfile-serialize

# Make sure to free the lock if we are killed
trap 'rm -f ${LOCKFILE}; exit 1' 1 2 3 15

# Retry forever
while true; do

  # Try to get the lock
  if shlock -p $$ -f ${LOCKFILE}; then
      sh -c "$1"
      result=$?
      rm -f ${LOCKFILE}
      exit $result
  fi

  # Sleep a random amount of time up to one second
  SLEEPTIME=$(echo $[ $RANDOM % 100 ] "/ 100" | bc -l)
  sleep $SLEEPTIME

done
