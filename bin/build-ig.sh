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


GIT_BRANCH=${TRAVIS_PULL_REQUEST_BRANCH:-${TRAVIS_BRANCH}}

# reset origin to default to work around Travis'
git remote remove origin
git remote add origin https://github.com/phenopackets/core-ig.git
cat ${GIT_ROOT}/.git/config
git fetch --all --tags
#git branch --all
#git tag -l

# first make sure we clean any previous published pages in case
# this build fails early
git worktree add -b gh-pages ${GIT_ROOT}/../core-ig-gh-pages origin/gh-pages
rm -rf "${GIT_ROOT}/../core-ig-gh-pages/$GIT_BRANCH" || true 
cd ${GIT_ROOT}/../core-ig-gh-pages
git reset gh-pages-start
git add -A &> /dev/null
git commit -m "Preparing build of $GIT_BRANCH"
git push -f --set-upstream "https://${COREIGTOKEN}@github.com/phenopackets/core-ig.git" gh-pages

cd $GIT_ROOT/fsh-generated
if [[ ! -f input-cache/publisher.jar ]]; then
	#./_updatePublisher.sh -f -y
    ${GIT_ROOT}/bin/get-publisher.sh
fi

./_genonce.sh

echo ================= FINISHED BUILDING =========================