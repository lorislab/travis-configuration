#!/bin/bash
set -ev

export MAVEN_CLI_OPTS="-s .scripts/maven/settings.xml --batch-mode --errors --fail-at-end --show-version"


export BUILD_VERSION=$(mvn help:evaluate -N -Dexpression=project.version|grep -v '\[')

# change version
if [[ $TRAVIS_BRANCH = master && $TRAVIS_PULL_REQUEST = false ]]; then
    BUILD_VERSION=${BUILD_VERSION%%-*}
    mvn $MAVEN_CLI_OPTS versions:set -DnewVersion=$BUILD_VERSION -q
fi
echo $BUILD_VERSION

# build
mvn $MAVEN_CLI_OPTS clean package

# deploy
if [[ ( $TRAVIS_BRANCH = master || $TRAVIS_BRANCH = develop) && $TRAVIS_PULL_REQUEST = false ]]; then
    mvn $MAVEN_CLI_OPTS -Dmaven.test.skip=true deploy
fi
