#!/bin/bash
set -e

export MAVEN_CLI_OPTS="-s .scripts/maven/settings.xml --batch-mode --errors --fail-at-end --show-version"

# integration tets
mvn $MAVEN_CLI_OPTS -Ptest-integration verify

mvn $MAVEN_CLI_OPTS sonar:sonar
