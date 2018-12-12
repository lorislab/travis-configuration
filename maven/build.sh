#!/bin/bash
set -ev

export VERSION=`$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)`
# change version
if [[ $TRAVIS_BRANCH = master && $TRAVIS_PULL_REQUEST = false ]]; then
    export VERSION=${VERSION%%-*}
fi
echo "Build version $VERSION"

# build
mvn -s .scripts/maven/settings.xml clean install

# deploy
if [[ ( $TRAVIS_BRANCH = master || $TRAVIS_BRANCH = develop) && $TRAVIS_PULL_REQUEST = false ]]; then
    mvn -s .scripts/maven/settings.xml deploy
fi
