#!/bin/bash
set -e

export MAVEN_CLI_OPTS="-s .scripts/maven/settings.xml --batch-mode --errors --fail-at-end --show-version"

# develop and pull-request
if [[ $TRAVIS_BRANCH = develop ]]; then

# unit tets
mvn $MAVEN_CLI_OPTS -Ptest-unit test

# integration tets
mvn $MAVEN_CLI_OPTS -Ptest-integration verify

fi
