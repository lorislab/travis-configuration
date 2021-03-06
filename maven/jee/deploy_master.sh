#!/bin/bash
set -e

export MAVEN_CLI_OPTS="-s .scripts/maven/settings.xml --batch-mode --errors --fail-at-end --show-version"

# deploy
if [[ ( $TRAVIS_BRANCH = master ) && $TRAVIS_PULL_REQUEST = false ]]; then
    mvn $MAVEN_CLI_OPTS -Prelease -Dmaven.test.skip=true deploy
fi
