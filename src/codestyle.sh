#!/usr/bin/env bash
SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}/" )" && pwd )"

# convert any windows path to linux style (c:/path, c:\path, /c/path => //c/path)
if [[ ! "$(uname -a)" == *"Linux"* ]] && [[ ! "$(uname -a)" == *"Darwin"* ]] ; then
    SRC_DIR=$(echo ${SRC_DIR} | sed 's/://g' | sed -r 's/\\/\//g' | sed -r 's/^[\/]*/\/\//')
fi

docker run -v $SRC_DIR/:/code/ --rm ivelum/codestyle:latest codestyle $*
