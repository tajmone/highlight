#!/bin/bash

# cwd: unpacked tarball dir
echo "Starting CI verification script"

git clone --depth 1 https://gitlab.com/tajmone/highlight-test-suite/

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

declare -a arr=("bash" "cpp" "exapunks" "hugo" "js" "lua"  "nim"  "perl"  "purebasic" "ruby")

for d in "${arr[@]}"
do
	bash ${TEST_DIR}/$d/regression.sh
	if [ $? -eq 0 ]; then
		echo "$d regression tests OK"
	else
		echo "$d regression tests FAILED"
		exit 1
	fi
done


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

