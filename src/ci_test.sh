#!/bin/bash

echo "Starting CI verification script"

#OUTPUT=`./src/highlight --list-scripts=langs`
./src/highlight --list-scripts=langs

RETVAL=$?

if [ $RETVAL -eq 0 ]; then
  echo "Retval is 0, OK"
else
  echo "Retval is not 0, FAIL"
  exit 1
fi

#if [ "$OUTPUT" == "BEGIN ... END" ]; then
#  echo "Output is correct, OK"
#else
#  echo "Output is not right, FAIL"
#  exit 1
#fi
