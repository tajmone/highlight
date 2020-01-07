#!/bin/bash

# cwd: unpacked tarball dir
echo "Starting CI verification script"

git clone https://gitlab.com/tajmone/highlight-test-suite/

#OUTPUT=`./src/highlight --list-scripts=langs`
HL_BIN=./src/highlight
TEST_DIR=./highlight-test-suite

${HL_BIN} --list-scripts=langs

if [ $? -eq 0 ]; then
	echo "--list-scripts OK"
else
	echo "--list-scripts FAILED"
	exit 1
fi

# new set of test scripts
bash ${TEST_DIR}/exapunks/regression.sh
if [ $? -eq 0 ]; then
	echo "exapunks regression tests OK"
else
	echo "exapunks regression tests FAILED"
	exit 1
fi


# old tests
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

${HL_BIN} ${TEST_DIR}/exapunks/syntax_test_macros.exa
if [ $? -eq 0 ]; then
	echo "exapunks test #1 OK"
else
	echo "exapunks test #1 FAILED"
	exit 1
fi
${HL_BIN} ${TEST_DIR}/exapunks/syntax_test_labels.exa
if [ $? -eq 0 ]; then
	echo "exapunks test #2 OK"
else
	echo "exapunks test #2 FAILED"
	exit 1
fi
${HL_BIN} ${TEST_DIR}/exapunks/syntax_test_numbers.exa
if [ $? -eq 0 ]; then
	echo "exapunks test #3 OK"
else
	echo "exapunks test #3 FAILED"
	exit 1
fi
${HL_BIN} ${TEST_DIR}/exapunks/syntax_test_registers.exa
if [ $? -eq 0 ]; then
	echo "exapunks test #4 OK"
else
	echo "exapunks test #4 FAILED"
	exit 1
fi
${HL_BIN} ${TEST_DIR}/exapunks/syntax_test_comments.exa
if [ $? -eq 0 ]; then
	echo "exapunks test #5 OK"
else
	echo "exapunks test #5 FAILED"
	exit 1
fi

${HL_BIN} ${TEST_DIR}/hugo/syntax_test_comments.hug
if [ $? -eq 0 ]; then
	echo "hugo test #1 OK"
else
	echo "hugo test #1 FAILED"
	exit 1
fi
${HL_BIN} ${TEST_DIR}/hugo/syntax_test_keywords.hug
if [ $? -eq 0 ]; then
	echo "hugo test #2 OK"
else
	echo "hugo test #2 FAILED"
	exit 1
fi
${HL_BIN} ${TEST_DIR}/hugo/syntax_test_strings.hug
if [ $? -eq 0 ]; then
	echo "hugo test #3 OK"
else
	echo "hugo test #3 FAILED"
	#no error until test case is adopted to UTF-8 fix in 3.53
	#exit 1
fi
${HL_BIN} ${TEST_DIR}/hugo/syntax_test_chars.hug
if [ $? -eq 0 ]; then
	echo "hugo test #4 OK"
else
	echo "hugo test #4 FAILED"
	exit 1
fi
${HL_BIN} ${TEST_DIR}/hugo/syntax_test_compiler-directives.hug
if [ $? -eq 0 ]; then
	echo "hugo test #5 OK"
else
	echo "hugo test #5 FAILED"
	exit 1
fi


# special configurations

echo '#!/usr/bin/perl' | ${HL_BIN} --verbose 2>&1 >/dev/null |  grep 'Description: Perl'
if [ $? -eq 0 ]; then
	echo "stdin shebang test #1 OK"
else
	echo "stdin shebang #1 FAILED"
	exit 1
fi

echo '#!/usr/bin/perl' | ${HL_BIN} --syntax-by-name xxx.py --verbose 2>&1 >/dev/null |  grep 'Description: Python'
if [ $? -eq 0 ]; then
	echo "stdin shebang test #2 OK"
else
	echo "stdin shebang #2 FAILED"
	exit 1
fi

echo 'ENFORCER' | ${HL_BIN} --force --fragment -O html | grep 'ENFORCER'
if [ $? -eq 0 ]; then
	echo "force option test #1 OK"
else
	echo "force option test #1 FAILED"
	exit 1
fi

