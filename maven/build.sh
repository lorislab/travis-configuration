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

git config --global user.email "lorislab@lorislab.org"
git config --global user.name "lorislab"
git tag $BUILD_VERSION -a -m "$BUILD_VERSION"
git push origin $TRAVIS_BRANCH --tags 2>&1

# build
mvn $MAVEN_CLI_OPTS -Prelease clean package

