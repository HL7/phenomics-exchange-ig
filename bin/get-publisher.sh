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
MAVEN_REPO=$(cat "$GIT_ROOT/tools.json" | jq -r '.publisher["maven-repo"]')
MAVEN_VERSION=$(cat "$GIT_ROOT/tools.json" | jq -r '.publisher["maven-version"]')

echo $GIT_ROOT
echo $MAVEN_REPO $MAVEN_VERSION

if [[ $MAVEN_REPO == "maven-release" ]]; then
    JAR_LOCATION="https://repo1.maven.org/maven2/org/hl7/fhir/publisher/org.hl7.fhir.publisher.cli/${MAVEN_VERSION}/org.hl7.fhir.publisher.cli-${MAVEN_VERSION}.jar"
elif [[ $MAVEN_REPO == "oss-snapshot" ]]; then
    JAR_LOCATION="https://oss.sonatype.org/service/local/artifact/maven/redirect?r=snapshots&g=org.hl7.fhir.publisher&a=org.hl7.fhir.publisher.cli&v=${MAVEN_VERSION}&e=jar"
else
    exit 1
fi

echo "Retrieving Publisher from ${JAR_LOCATION}"

mkdir -p "${GIT_ROOT}/ig-root/input-cache/"
wget --output-document="${GIT_ROOT}/ig-root/input-cache/publisher.jar" \
    "$JAR_LOCATION"