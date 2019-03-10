#!/bin/bash
set -e

export MAVEN_CLI_OPTS="-s .scripts/maven/settings.xml --batch-mode --errors --fail-at-end --show-version"

# deploy

if [[ $TRAVIS_PULL_REQUEST = false ]]; then
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

    if [[ ( $TRAVIS_BRANCH = master ) ]]; then
        mvn $MAVEN_CLI_OPTS -Pdocker-push dockerfile:push
    fi
    if [[ ( $TRAVIS_BRANCH = develop ) ]]; then
        mvn $MAVEN_CLI_OPTS -Pdocker-push -Ddockerfile.tag=latest dockerfile:push
    fi
fi
