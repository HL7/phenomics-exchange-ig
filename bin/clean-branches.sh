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

BRANCHES=($(git for-each-ref --format="%(refname)"))
echo "${BRANCHES[*]}"

IFSO="$IFS"
IFS=$'\n'

for i in $(ls -d */)
do 
    if [[ "${BRANCHES[*]}" != *origin/${i%%/}* ]]; then
        echo directory $i is not in branches
        echo deleting directory ${i%%/}
    fi

#    echo ${i%%/}; 
done