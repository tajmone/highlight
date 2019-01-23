#!/bin/bash

echo "Starting CI verification script"

cd ~
git clone https://gitlab.com/tajmone/highlight-test-suite/

#OUTPUT=`./src/highlight --list-scripts=langs`
HL_BIN=./src/highlight
TEST_DIR=~/highlight-test-suite

${HL_BIN} --list-scripts=langs

if [ $? -eq 0 ]; then
  echo "--list-scripts OK"
else
  echo "--list-scripts FAILED"
  exit 1
fi

${HL_BIN} ${TEST_DIR}/bash/syntax_test_heredoc.sh
if [ $? -eq 0 ]; then
  echo "bash test #1 OK"
else
  echo "bash test #1 FAILED"
  exit 1
fi

${HL_BIN} ${TEST_DIR}/js/syntax_test_string.js
if [ $? -eq 0 ]; then
  echo "js test #1 OK"
else
  echo "js test #1 FAILED"
  exit 1
fi
${HL_BIN} ${TEST_DIR}/nim/syntax_test_keywords.nim 
if [ $? -eq 0 ]; then
  echo "nim test #1 OK"
else
  echo "nim test #1 FAILED"
  exit 1
fi
${HL_BIN} ${TEST_DIR}/perl/syntax_test_heredoc.pl
if [ $? -eq 0 ]; then
  echo "perl test #1 OK"
else
  echo "perl test #1 FAILED"
  exit 1
fi
${HL_BIN} ${TEST_DIR}/ruby/syntax_test_heredoc.rb
if [ $? -eq 0 ]; then
  echo "ruby test #1 OK"
else
  echo "ruby test #1 FAILED"
  exit 1
fi
${HL_BIN} ${TEST_DIR}/lua/syntax_test_com_str.lua
if [ $? -eq 0 ]; then
  echo "lua test #1 OK"
else
  echo "lua test #1 FAILED"
  exit 1
fi

#if [ "$OUTPUT" == "BEGIN ... END" ]; then
#  echo "Output is correct, OK"
#else
#  echo "Output is not right, FAIL"
#  exit 1
#fi
