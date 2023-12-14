#!/usr/bin/env bash
#set -x
set -e
set -u
set -o pipefail
set -o noclobber
#set -f # no globbing
#shopt -s failglob # fail if glob doesn't expand

# See http://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
    DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

cd "$DIR"

# The usual publisher options/arguments can be added to the end of this line, as done for the -ig option.
# The "latest" tag can be replaced with a publisher version as long as there is an image built for it.
# Check for available images here: https://hub.docker.com/repository/docker/sessaid/ig-publisher/tags
docker run --pull=always --rm --volume "$(pwd):/ig" sessaid/ig-publisher:latest -ig ig.ini