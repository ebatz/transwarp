#!/bin/bash
set -e
thisdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "+++ Running CppCheck (assuming version 1.83) ..."
output=$(cppcheck --template="{file};{line};{severity};{id};{message}" --quiet \
--enable=all --std=c99 --std=c++11 --relative-paths --suppress=missingIncludeSystem \
--suppress=syntaxError --suppress=passedByValue --force --inline-suppr \
--suppress=*:$thisdir/examples/boost/* $thisdir/src/transwarp.h \
$thisdir/examples/*.cpp $thisdir/examples/*.h 2>&1)
if [ "x$output" != "x" ];then
    echo "CppCheck Failed:"
    echo $output
    exit 1  
fi 
echo "CppCheck OK"
