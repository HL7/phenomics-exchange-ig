#!/usr/bin/env bash
set -x
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

# find git branch for the original commit
GIT_BRANCH=${TRAVIS_PULL_REQUEST_BRANCH:-${TRAVIS_BRANCH}}
BRANCHES=($(git for-each-ref --format="%(refname)"))

# 
cat ${GIT_ROOT}/.git/config
git fetch --all --tags
git fetch -f --tags origin gh-pages:refs/remotes/origin/gh-pages
git branch --all
git tag -l
git worktree add -b gh-pages ${GIT_ROOT}/../core-ig-gh-pages origin/gh-pages
cd ${GIT_ROOT}/../core-ig-gh-pages

git status

#git pull --ff-only

# clean directories for non existing branches, and just built branch
ls -la
rm -rf "$GIT_BRANCH"
IFSO="$IFS"
IFS=$'\n'
for i in $(ls -d */)
do 
    echo checking directory $i
    if [[ "${BRANCHES[*]}" != *origin/${i%%/}* ]]; then
        echo deleting directory ${i%%/}
        rm -rf ${i%%/}
    fi
done

# copy over build
cp -ra ${GIT_ROOT}/ig-root/output "$GIT_BRANCH"
rm README.md
echo "# Built branches" > README.md
for i in $(ls -d */)
do 
    echo "["${i%%/}"]""("${i}")" >> README.md
done

git reset gh-pages-start
git add -A &> /dev/null
git commit -m "Build of $GIT_BRANCH"
git push -f --set-upstream "https://${COREIGTOKEN}@github.com/phenopackets/core-ig.git" gh-pages
echo ================= FINISHED PUBLISHING =========================

env