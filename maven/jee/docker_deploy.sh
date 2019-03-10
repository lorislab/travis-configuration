#!/bin/bash
set -e

export MAVEN_CLI_OPTS="-s .scripts/maven/settings.xml --batch-mode --errors --fail-at-end --show-version"

# deploy
echo $BUILD_VERSION

if [[ $TRAVIS_PULL_REQUEST = false ]]; then
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
    export DOCKER_TAG=latest

    if [[ ( $TRAVIS_BRANCH = master ) ]]; then
        export BUILD_VERSION=$(mvn help:evaluate -N -Dexpression=project.version|grep -v '\[')
        DOCKER_TAG=${BUILD_VERSION%%-*}
    fi
    mvn $MAVEN_CLI_OPTS -Ddockerfile.tag=$DOCKER_TAG dockerfile:push
fi
