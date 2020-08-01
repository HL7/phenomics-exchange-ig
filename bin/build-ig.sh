#!/usr/bin/env bash
#set -x
set -e
set -u
set -o pipefail
set -o noclobber

# See http://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

GIT_ROOT="$(dirname "$DIR")"

if [[ ! -f $GIT_ROOT/ig-root/input-cache/publisher.jar ]]; then
    ${GIT_ROOT}/bin/get-publisher.sh
fi

java -jar ${GIT_ROOT}/ig-root/input-cache/publisher.jar  -ig ${GIT_ROOT}/ig-root/ig.ini