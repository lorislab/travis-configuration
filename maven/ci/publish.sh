#!/bin/bash
set -e

export MAVEN_CLI_OPTS="-s .scripts/maven/settings.xml --batch-mode --errors --fail-at-end --show-version"

if [[ $TRAVIS_PULL_REQUEST = false && ( $TRAVIS_BRANCH = develop ) ]]; then
    echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
    mvn $MAVEN_CLI_OPTS dockerfile:push
fi
