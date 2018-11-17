#!/bin/bash

LOCKFILE=~/.lockfile-serialize

# Determine which lock strategy to use
if which flock > /dev/null; then
  LOCK_METHOD=flock
elif which shlock > /dev/null; then
  LOCK_METHOD=shlock
else
  echo "No usable lock method"
  exit 1
fi

# Make sure to free the lock if we are killed
trap 'rm -f ${LOCKFILE}; exit 1' 1 2 3 15

# Retry forever
while true; do

  # Try to get the lock
  if [ "$LOCK_METHOD" == "shlock" ] && shlock -p $$ -f ${LOCKFILE}; then
    sh -c "$1"
    retval=$?
    rm $LOCKFILE
    exit $retval
  elif [ "$LOCK_METHOD" == "flock" ]; then
    flock -n -E 251 $LOCKFILE sh -c "$1"
    retval=$?
    rm $LOCKFILE
    if [ "$retval" != "251" ]; then
      exit $retval
    fi      
  fi

  # Sleep a random amount of time up to one second
  SLEEPTIME=$(echo $[ $RANDOM % 100 ] "/ 100" | bc -l)
  sleep $SLEEPTIME

done
