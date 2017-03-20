#!/bin/bash
# simple script to check if requested version of JDK is installed, and set if JAVA_HOME is set.
#
# @return: JSON string : { "jdkVersionFound": true or false, "jdkHomeFound": true or false }
#

JAVA_VERSION="\"$1\""

version_check=$(java -version 2>&1  | grep $JAVA_VERSION -c)
javahome_check=${#JAVA_HOME}

if [[ $version_check > 0 ]]
then
    if [[ $javahome_check > 0 ]]
    then
        echo '{ "jdkVersionFound": true , "jdkHomeFound": true  }'
    else
        echo '{ "jdkVersionFound": true , "jdkHomeFound": false  }'
    fi
else
    echo '{ "jdkVersionFound": false  , "jdkHomeFound": false }'
fi